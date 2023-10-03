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
const { sendMail } = require('./notifications.js');
const TOKEN = process.env.TOKEN_BOT;

client.login(TOKEN);

client.on('ready', () => {
    console.log(`Logged in as ${client.user.tag}!`);
});

client.on('messageCreate', (msg) => {
    if (msg.guild && msg.guild.id === process.env.DISCORD_SERVER_ID) {
        const messages = msg.content;

        console.log(`Message from ${msg.author.tag}: ${messages}`);
        sendMail(messages);
    }
});

module.exports = client;