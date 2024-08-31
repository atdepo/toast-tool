// Require the necessary discord.js classes
const dotenv = require('dotenv')
const {
    Client, GatewayIntentBits, Routes} = require('discord.js');
const {REST} = require('@discordjs/rest');
const {commands, questions, gamma, smellsNames} = require('./toast.utilities');
const fs = require('fs');
const {executeInteractionSelectMenu, executeInteractionButtons, executeChatInteraction, executeModalInteraction} = require("./toast.service");
let jsonUserData = {};


// the main function that manages the bot
async function main() {

    // load the environment variables from the .env file
    // and initialize the variables needed for the bot
    dotenv.config();
    let interactionInProgress = false;
    global.index = 0;
    let smellValues = new Map();
    const client = new Client({
        intents: [
            GatewayIntentBits.Guilds,
            GatewayIntentBits.GuildMessages,
            GatewayIntentBits.MessageContent
        ]
    });

    global.messagesIds = new Map();
    global.choicesIds = new Map();
    const rest = new REST({version: '10'}).setToken(process.env.DISCORD_TOKEN);

    try {
        console.log("Started refreshing application (/) commands.");

        await rest.put(Routes.applicationCommands(process.env.CLIENT_ID), {
            body: commands,
        });

        client.login(process.env.DISCORD_TOKEN).then(() => {
            console.log('TOAST is ready!');
            const data = fs.readFileSync('users.json', 'utf8');
            jsonUserData = JSON.parse(data);
        });

        client.on('interactionCreate', async interaction => {

            //console.log("id " + interaction.id)
            //console.log("username " + interaction.user.username)
            //console.log("channelId " + interaction.channelId)
            //console.log("userId " + interaction.user.id)

            // if the interaction is a command (/start) and the bot is not already interacting with the user
            if (interaction.isChatInputCommand()) {
                await executeChatInteraction(interaction, jsonUserData)
            }
            // if the interaction is a button interaction
            else if (interaction.isButton()) {
                await executeInteractionButtons(smellValues, interaction)
            }
            // if the interaction is a select menu interaction
            else if (interaction.isStringSelectMenu()) {
                await executeInteractionSelectMenu(interaction, jsonUserData)
            }
            // else, if the interaction is a modal interaction (and so it is processing the data of the new collaborator)
            else if (interaction.isModalSubmit()) {
                await executeModalInteraction(interaction, jsonUserData)
            }
        });
    } catch (error) {
        console.error(error);
    }
}

main();
