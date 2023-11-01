require('dotenv').config();
const { Client, GatewayIntentBits } = require('discord.js');
const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent,
        GatewayIntentBits.DirectMessages,
    ],
});
const { sendMail } = require('../notifications.js');
const TOKEN = process.env.TOKEN_BOT;
let nbMessages = 0;

client.login(TOKEN);

client.on('ready', () => {
    console.log(`Logged in as ${client.user.tag}!`);
});

client.on('messageCreate', (msg) => {
    if (msg.guild && msg.guild.id === process.env.DISCORD_SERVER_ID) {
        const messages = msg.content;
        nbMessages++;

        console.log(`Message from ${msg.author.tag}: ${messages}`);
        if (nbMessages === 5) {
            sendMail(messages);
            nbMessages = 0;
        }
    }
});

module.exports = client;