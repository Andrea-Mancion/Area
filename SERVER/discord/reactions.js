const BotClient = require('./myBot.js');
const DiscordStrategy = require('passport-discord').Strategy;
const axios = require('axios');
const cron = require('node-cron');
const { time } = require('console');
require('dotenv').config();

async function callReactionDiscord(area) {
  if (area.reaction_Name == "list_message")
    listMessage();
  if (area.reaction_Name == "send_message")
    sendMessage();
  if (area.reaction_Name == "send_weather")
    sendWeather();
  return;
}

module.exports = { callReactionDiscord };

function listMessage() {
    const channel = BotClient.channels.cache.get(process.env.DISCORD_CHANNEL);
    if (channel && channel.isTextBased()) {
      console.log("I Have the channe");

      channel.messages.fetch().then(messages => {
        const messagesArray = messages.map(message => ({
          author: message.author.tag,
          content: message.content,
        }));
        res.json(messagesArray);
      }).catch(error => {
        console.error("Error: " + error);
      });
    } else
      console.log("I don't have the channel");
}

function sendMessage() {
    const { message } = req.body;
    const channel = BotClient.channels.cache.get(process.env.DISCORD_CHANNEL);

    if (channel && channel.isTextBased()) {
      channel.send(message).then(() => {
        console.log("Message sent");
      }).catch(error => {
        console.error("Error: " + error);
      });
    } else
      console.log("I don't have the channel");
}

function sendWeather() {
    const city = 'rennes';
    const apiKey = process.env.WEATHER_API_KEY;

    axios.get(`http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}`).then(response => {
      const weatherData = response.data;
      const temp = Math.round(weatherData.main.temp - 273.15);
      const condition = weatherData.weather[0].description;

      const weatherMessage = `Weather in ${city}: ${temp} degrees Celcius, ${condition}`;
      const channel = BotClient.channels.cache.get(process.env.DISCORD_CHANNEL);

      if (channel && channel.isTextBased()) {
        channel.send(weatherMessage).then(() => {
          console.log("Message sent");
        }).catch(error => {
          console.error("Error: " + error);
        });
      } else
        console.log("I don't have the channel");
    }).catch(error => {
      console.error("Error: " + error);
    });
}
