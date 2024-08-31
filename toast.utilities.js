const {
    StringSelectMenuBuilder,
    StringSelectMenuOptionBuilder,
    ActionRowBuilder,
    ModalBuilder,
    TextInputBuilder,
    TextInputStyle,
    ButtonBuilder,
    ButtonStyle
} = require("discord.js");

/***************************************************/
/********************General************************/
/***************************************************/

const commands = [
    {
        name: 'start',
        description: 'Start the bot',
    }
];

const questions = [

    //Weights sum: 8.345
    //Lone Wolf questions
    {
        content: "The contributor has insufficient communication with the team",
        original_weight: 3.774,
        norm_weight:0.452,
        smell: "LW"
    },
    {
        content: "The contributor does not take into account the activities of other team members",
        weight: 4.571,
        norm_weight:0.548,
        smell: "LW"
    },

    //Weights sum: 9.129
    //Prima Donna questions
    {
        content: "The contributor has an unwillingness to accept help or support from peers",
        weight: 4.702,
        norm_weight:0.515,
        smell: "PD"
    },
    {
        content: "The contributor refuses to listen to the ideas or opinions of peers",
        weight: 4.427,
        norm_weight:0.485,
        smell: "PD"
    },

    //Weights sum: 10.268
    //Black Cloud questions
    {
        content: "The contributor takes matters and decisions in their own hand",
        weight: 2.659,
        norm_weight:0.259,
        smell: "BC"
    },
    {
        content: "The contributor hoard critical knowledge and not share it",
        weight: 3.576,
        norm_weight:0.348,
        smell: "BC"
    },
    {
        content: "The contributor does not communicate effectively with other peers",
        weight: 4.033,
        norm_weight:0.393,
        smell: "BC"
    },

    //Weights sum: 8.975
    //Lonesome Architecting
    {
        content: "The contributor complained of a lack of knowledge of the product requirements",
        weight: 3.273,
        norm_weight:0.365,
        smell: "LA"
    },
    {
        content: "The contributor complained of a loss of general vision of the product",
        weight: 2.733,
        norm_weight:0.304,
        smell: "LA"
    },
    {
        content: "The contributor was called upon to make architectural decisions that were not his responsibility",
        weight: 2.969,
        norm_weight:0.331,
        smell: "LA"
    },
]

const smellsNames = {
    "LW": ":wolf: Lone Wolf",
    "PD": ":princess::skin-tone-1: Prima Donna",
    "BC": ":cloud: Black Cloud",
    "LA": " :tools: Lonesome Architecting"
}

const gamma = {
    "strDis": {value: -1},
    "dis": {value: -0.5},
    "neutral": {value: 0},
    "agree": {value: 0.5},
    "strAgree": {value: 1}
};

/***************************************************/
/********************Buttons************************/
/***************************************************/

const strDis = new ButtonBuilder()
    .setCustomId('strDis')
    .setLabel('Strongly Disagree')
    .setStyle(ButtonStyle.Danger);

const dis = new ButtonBuilder()
    .setCustomId('dis')
    .setLabel('Disagree')
    .setStyle(ButtonStyle.Danger);

const neutral = new ButtonBuilder()
    .setCustomId('neutral')
    .setLabel('Neither Agree nor Disagree')
    .setStyle(ButtonStyle.Primary);

const agree = new ButtonBuilder()
    .setCustomId('agree')
    .setLabel('Agree')
    .setStyle(ButtonStyle.Success);

const strAgree = new ButtonBuilder()
    .setCustomId('strAgree')
    .setLabel('Strongly Agree')
    .setStyle(ButtonStyle.Success)
;

const likertScale = new ActionRowBuilder()
    .addComponents(strDis, dis, neutral, agree, strAgree);

/***************************************************/
/********************Menu***************************/
/***************************************************/


const select = new StringSelectMenuBuilder()
    .setCustomId('starter')
    .setPlaceholder('Which action you want to perform?')
    .addOptions(
        new StringSelectMenuOptionBuilder().setLabel('Add a new collaborator to your team')
        .setDescription('Add a new collaborator to your team to analyze the behavior')
        .setValue('add'),
        new StringSelectMenuOptionBuilder().setLabel('Start the analysis of a collaborator')
        .setDescription('Start the analysis questions. Select a collaborator to start ')
        .setValue('start'),
        new StringSelectMenuOptionBuilder().setLabel('Delete an existing collaborator')
        .setDescription('Delete an existing collaborator in your team')
        .setValue('del')
        );

const row = new ActionRowBuilder()
    .addComponents(select);

const modal = new ModalBuilder()
    .setCustomId('myModal')
    .setTitle('Add a new collaborator to your team')
    .addComponents(
    new ActionRowBuilder().addComponents(new TextInputBuilder()
        .setCustomId('nameInput')
        // The label is the prompt the user sees for this input
        .setLabel("Name of the collaborator")
        // Short means only a single line of text
        .setStyle(TextInputStyle.Short)
    ))
    .addComponents(
    new ActionRowBuilder().addComponents(new TextInputBuilder()
        .setCustomId('surnameInput')
        // The label is the prompt the user sees for this input
        .setLabel("Surname of the collaborator")
        // Short means only a single line of text
        .setStyle(TextInputStyle.Short)
    ))
    .addComponents(
    new ActionRowBuilder().addComponents(new TextInputBuilder()
        .setCustomId('idInput')
        // The label is the prompt the user sees for this input
        .setLabel("ID of the collaborator")
        // Short means only a single line of text
        .setStyle(TextInputStyle.Short)
    ));

const mod2 = new ModalBuilder()
    .setCustomId("deleteModal")
    .setTitle("Delete a Collaborator")
    .addComponents(select)

/***************************************************/
/********************Exports************************/
/***************************************************/

/*****General Export*****/
module.exports.commands = commands;
module.exports.questions = questions;
module.exports.gamma = gamma;
module.exports.smellsNames = smellsNames;

/*****Buttons Export*****/
module.exports.likertScale = likertScale;

/*****Menu Export*****/
module.exports.row = row;
module.exports.modal = modal;
