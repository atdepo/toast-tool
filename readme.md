# TOAST Tool - Team Observation And Smells Tracking Tool

## Introduction

TOAST (Team Observation And Smells Tracking Tool) is a proof-of-concept recommendation system developed to make our research on community smell symptoms practical and actionable for practitioners. Built on the Discord platform, TOAST empowers managers to conduct manual analyses using a catalog of validated symptoms, leveraging their expertise to identify and mitigate community smells early in software development teams.

### Key Features

- Survey-based methodology for identifying community smells
- Interactive questionnaire for evaluating team members' behaviors
- Weighted scoring system for assessing susceptibility to various community smells
- Flexible, numerical scoring approach to accommodate diverse organizational contexts

### Objectives

1. Enhance practitioners' awareness of potential issues within their teams
2. Integrate seamlessly with widely-used recommendation systems in software development environments

## Setup Instructions

To use this tool, follow these steps:

1. Clone the repository:
2. As the tool is implemented using the NodeJS framework, install the necessary dependencies by running: 

    ```npm update npm install```

## Creating a Discord Bot

To create the Discord bot required for the tool to function:

1. Log in to your Discord account.
2. Create a new **Discord Application** at [https://discord.com/developers/applications](https://discord.com/developers/applications).
3. Click ** Add Bot ** to create a new bot using the **Bot** tab on the left side of the page.
4. Retrieve the bot's token (the **DISCORD_TOKEN**) by clicking the **Reset Token** button.
5. From the OAuth2 tab, General section, retrieve your **CLIENT_ID**.
6. Still in the OAuth2 tab, use the **URL Generator** section to create an invite link for the bot:
   1) Select *application.commands* to allow the bot to listen for (and be invoked by) Discord commands.
   2) Select *bot*. Once selected, additional options will appear below. These are the permissions for operations the bot can perform on the server. For the tool to function properly, select the *Send Messages* and *Manage Messages* permissions.
   3) Copy the link at the bottom of the page, which will contain information about all the permissions you want Discord to grant the bot and its usage scopes.
7. Use the retrieved link to add the bot to your chosen Discord server.
8. From the server information panel, with Discord developer mode enabled, retrieve the **GUILD_ID**.

## Configuration

Using the tokens gathered in the process, complete the **.env** file in the bot's folder.

## Running the Tool

Once all these operations are completed, start the tool's backend using the command:

```node toast.js```
