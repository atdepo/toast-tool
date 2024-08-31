const {StringSelectMenuBuilder, StringSelectMenuOptionBuilder, ActionRowBuilder} = require("discord.js");
const {questions, gamma, smellsNames} = require("./toast.utilities");
const {likertScale} = require("./toast.utilities");
const {row, modal} = require("./toast.utilities");
const fs = require("fs");
const {saveNewUser, saveNewCollaborator, updateMap, deleteCollaborator} = require("./toast.model");


async function executeInteractionSelectMenu(interaction, jsonUserData){
    // if the interaction is a select menu interaction (and so it is processing the collaborators list)
    // get the id of the collaborator selected by the user
    let choice = interaction.values[0];

    // if the user selected the collaborator to analyze
    if (choice.includes("analyze")) {

        // get the id of the collaborator selected by the user
        let id = choice.split(" ")[1];
        // get the collaborator data from the json file
        let collaborator = jsonUserData.users.find((el) => el.userId === interaction.user.id).collaborators.find((el) => el.collaboratorId === id)

        global.full = `${collaborator.name} ${collaborator.surname}`;
        await interaction.reply({
            content: `Beginning analysis of ${collaborator.name} ${collaborator.surname}`,
            components: [],
        })
        const replyMessage = await interaction.fetchReply();
        global.messagesIds.set(interaction.user.id, [replyMessage.id]);

        // start the questions interaction with the collaborator selected
        await nextQuestionButton(interaction, global.index);
    } else if(choice.includes("delete")){

        // get the id of the collaborator selected by the user
        let id = choice.split(" ")[1];
        // get the collaborator data from the json file
        deleteCollaborator(interaction.user.id,id,jsonUserData);
        await interaction.reply({
            content: `Deleting ${id} from your team`,
            components: [row],
        })
    }
    // else, if the user selected one of the options of the select menu
    else {
        switch (choice) {
            // the user has selected the option to start the analysis,
            // so we have to show him the list of his collaborators to choose the one to analyze
            case 'start':
                await removeMsg(global.choicesIds, interaction);

                let collaborators = getCollabsByUserID(interaction.user.id, jsonUserData);
                if (collaborators.length !== 0) {
                    let options = buildCollabsList(collaborators, 'analyze');
                    await interaction.reply({
                        content: "Choose the collaborator you want to analyze",
                        components: [options],
                    });
                    const replyMessage = await interaction.fetchReply();
                    global.choicesIds.set(interaction.user.id, [replyMessage.id]);
                }
                break;
            // the user has selected the option to add a new collaborator,
            // so we have to show him the modal to insert the data of the new collaborator
            case 'add':
                //await removeMsg(global.choicesIds, interaction);
                // Show the modal to the user
                await interaction.showModal(modal);
                break;

            case 'del':
                let collabs = getCollabsByUserID(interaction.user.id, jsonUserData);

                if (collabs.length !== 0) {
                    let options = buildCollabsList(collabs,'delete');
                    await interaction.reply({
                        content: "Choose the collaborator you want to delete",
                        components: [options],
                    });

                } else{
                    interaction.reply({
                        content: "You have no collaborator associated to your id. Try adding them before deleting ",
                        components: [row],
                    })
                }
                break;
            default:
                break;
        }
    }
}

async function executeInteractionButtons(smellValues,interaction){
    // update the smellValues map with the answer of the user
    updateMap(interaction, global.index, gamma, smellValues)
    let content;

    if (global.index + 1 < questions.length)
        content = `Question #${global.index+1}/${questions.length} answered. Next question`;
    else
        content = `Question #${global.index+1}/${questions.length} answered.\nAll questions have been answered, the messages will be cleared.`;

    await interaction.update({
        content: content,
        components: [],
    });
    // add the id of the message to the map of the messages to delete them later
    global.messagesIds.get(interaction.user.id).push(interaction.message.id);
    setTimeout(function() {
    }, 1000);
    global.index = global.index + 1;
    // if there are still questions to ask, ask the next one
    if (global.index < questions.length)
        await nextQuestionButton(interaction, global.index);
    // else, the interaction is finished and the bot can give the result
    else {
        global.index = 0;
        console.log(smellValues);

        // sleep for 1 second to let the user realize that the interaction is finished
        setTimeout(function() {
            }, 1000);
        // delete all the messages sent by the bot during the interaction
        if (global.messagesIds.get(interaction.user.id) !== undefined) {
            let row = global.messagesIds.get(interaction.user.id);

            for (let elem of row) {
                try {
                    let message = await interaction.channel.messages.fetch(elem);
                    await message.delete();
                } catch (error) {
                    console.error("non sono riuscito ad eliminare il messageId:" + elem);
                }
            }

            global.messagesIds.delete(interaction.user.id);
        }

        // get the smell values of the collaborator analyzed
        let values = smellValues.get(interaction.user.id);
        let message = `The following are ${global.full} values of Community Smells:`;

        for (let value of values) {
            let smellAcr = value[0];
            let smellValue = value[1];

            const smellName = smellsNames[smellAcr];
            message += `\n${smellName}: ${smellValue}`;

        }

        message += "\nLet\'s continue the job shall we?";

        // send the result to the user and save the message id to delete it later
        //interaction.channel.send(message).then((msg) => {
        //    global.messagesIds.set(interaction.user.id, [msg.id])
        //});

        // delete the smellValues map entry
        smellValues.delete(interaction.user.id);

        await interaction.followUp({
        content: message,
        components: [row],
            });
    }
}

async function executeChatInteraction(interaction, jsonUserData){
    if (interaction.commandName === 'start') {
        await interaction.reply({
            content: '👋 Hello there! Welcome to TOAST \n' +
                '\n' +
                '(That\'s short for Team Observation and Smells Tracking Tool) 🕵️‍♂️\n' +
                '\n' +
                'I\'m your friendly neighborhood bot, here to help you prevent\n Community Smells among your collaborators!\n' +
                '\n' +
                'Here\'s how it works:\n' +
                '1️⃣ I\'ll ask you a series of questions about a collaborator\n' +
                '2️⃣ You\'ll share your observations\n' +
                '3️⃣ I\'ll calculate up a report of 4 types of Community Smells📊\n' +
                '\n' +
                'Ready to get started? Let\'s dive in and make your team even better! 🚀',
            components: [row],
        })

        // get the discordId of the user that started the interaction
        // and save it in the json file if it is not already present
        let user = getUserById(interaction.user.id, jsonUserData);
        if (user === undefined) {
            saveNewUser(interaction.user.id, jsonUserData);
        }
    }
}

async function executeModalInteraction(interaction, jsonUserData){
    console.log(interaction.fields.fields);

    let name = interaction.fields.fields.get('nameInput').value;
    let surname = interaction.fields.fields.get('surnameInput').value;
    let id = interaction.fields.fields.get('idInput').value;

    await interaction.reply({
        content: 'The collaborator '+ name + ' ' + surname + ' has been added to your team!\n Let\'s continue the job shall we?',
        components: [row],
    })
    const replyMessage = await interaction.fetchReply();
    global.choicesIds.set(interaction.user.id, [replyMessage.id]);

    saveNewCollaborator(interaction.user.id, name, surname, id, jsonUserData);
}
async function removeMsg(list, interaction) {
    let row = list.get(interaction.user.id);

    if (row !== undefined) {
        for (let elem of row) {
            try {
                let message = await interaction.channel.messages.fetch(elem);
                await message.delete();
            } catch (error) {
                console.error("non sono riuscito ad eliminare il messageId:" + elem);
            }
        }
        list.delete(interaction.user.id);
    }
}

function buildCollabsList(collaborators, action) {
    let select = new StringSelectMenuBuilder()
        .setCustomId('collab_picker')
        .setPlaceholder('Your Collaborators');

    for (let collaborator of collaborators) {
        select.addOptions(
            new StringSelectMenuOptionBuilder()
                .setLabel(collaborator.name + " " + collaborator.surname + " ID: " + collaborator.collaboratorId)
                .setValue(`${action} ${collaborator.collaboratorId}`));
    }

    return new ActionRowBuilder()
        .addComponents(select);
}

function getCollabsByUserID(userId, jsonUserData) {
    let user = jsonUserData.users.find((el) => {
        return el.userId === userId
    });
    if (user.length === 0) {
        saveNewUser(userId, jsonUserData);
        return [];
    } else
        return user.collaborators;
}

async function nextQuestionButton(interaction, index) {

    await interaction.followUp({
        content: questions[index].content,
        components: [likertScale],
    });
}

function getUserById(userId, jsonUserData) {
    return jsonUserData.users.find((el) => {
        return el.userId === userId
    });
}

module.exports.executeInteractionSelectMenu = executeInteractionSelectMenu;
module.exports.executeInteractionButtons = executeInteractionButtons;
module.exports.executeChatInteraction = executeChatInteraction;
module.exports.executeModalInteraction = executeModalInteraction;
