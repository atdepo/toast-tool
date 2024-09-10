# TOAST

> **T**eam **O**bservation **A**nd **S**mells **T**racking Tool

## 🌟 Introduction

TOAST is a proof-of-concept recommendation system designed to make research on community smell symptoms practical and actionable for practitioners. Built on the Discord platform, TOAST empowers managers to:

- Conduct manual analyses using a catalog of validated symptoms
- Leverage their expertise to identify and mitigate community smells early in software development teams

## 🚀 Key Features

- Survey-based methodology for identifying community smells
- Interactive questionnaire for evaluating team members' behaviors
- Weighted scoring system for assessing susceptibility to various community smells
- Flexible, numerical scoring approach to accommodate diverse organizational contexts

## 🎯 Objectives

1. Enhance practitioners' awareness of potential issues within their teams
2. Integrate seamlessly with widely-used recommendation systems in software development environments

## 🏛️ Repository Structure
All the files in this repository are related to the tool source code. In the `data_files` directory
there are the files that were used during the research project that led to the development of the tool.

Specifically, the directory contains:
- The file `Selection Survey for Community Smells Recognition - Answers.xlsx` that contains the answers to 
the exploratory survey used to find the set of managerial figures to interview
- The file `An Empirical Study on Community Smells within Project Teams - Answers.xlsx` that contains the answers to the two iterations of 
the main survey, aggregated in a single sheet
- The file `analisi_rq_2.R` that contains the R scripts used to calculate the metrics used to answer the second research question
- The file `Coding Sheet.xlsx` that contains the coding process that was followed to identify the symptoms from the literature

## 🛠️ Setup Instructions

### Prerequisites

- Node.js
- npm (Node Package Manager)
- Git

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/atdepo/toast-tool.git
   cd toast-tool
   ```

2. Install dependencies:
   ```
   npm update
   npm install
   ```

## 🤖 Creating a Discord Bot

1. Log in to your [Discord account](https://discord.com/)
2. Create a new **Discord Application** at [Discord Developer Portal](https://discord.com/developers/applications)
3. In the **Bot** tab, click **Add Bot**
4. Get your bot token (DISCORD_TOKEN) by clicking **Reset Token**
5. From the **OAuth2** tab, retrieve your **CLIENT_ID**
6. Generate an invite link for your bot:
   - Select `application.commands` and `bot` scopes
   - Choose `Send Messages` and `Manage Messages` permissions
7. Use the generated link to add the bot to your Discord server
8. Retrieve the **GUILD_ID** from your server (with developer mode enabled)

## ⚙️ Configuration

Complete the `.env` file in the bot's folder with the tokens you've gathered:

```env
DISCORD_TOKEN=your_bot_token_here
CLIENT_ID=your_client_id_here
GUILD_ID=your_guild_id_here
```

## 🚀 Running the Tool

Start the tool's backend:

```
node toast.js
```

---

📝 **Note**: Make sure to keep your bot token and other sensitive information secure. Never share them publicly or commit them to version control.
