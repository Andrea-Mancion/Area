const BotClient = require('../myBot.js');
const DiscordStrategy = require('passport-discord').Strategy;
const axios = require('axios');
const cron = require('node-cron');
const { time } = require('console');
const { callReaction } = require('./reactions');
const fs = require('fs');
require('dotenv').config();

async function callActionDiscord(area) {
    const action_Name = area.action_Name;
    if (action_Name == "weather_hour") {
        if (weatherHour())
          await callReaction(area);
    }
    if (action_Name == "weather_diff") {
        if (weatherDiff())
          await callReaction(area);
    }
}

function weatherHour() {
  cron.schedule('0 10 * * *', () => {
    const city = 'rennes';
    const apiKey = process.env.WEATHER_API_KEY;

    axios.get(`http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}`).then(response => {
      const weatherData = response.data;
      const temp = Math.round(weatherData.main.temp - 273.15);
      const condition = weatherData.weather[0].description;

      const weatherMessage = `Weather in ${city}: ${temp} degrees Celcius, ${condition}`;
      const channel = BotClient.channels.cache.get(process.env.DISCORD_CHANNEL);

      if (channel && channel.isTextBased()) {
        fs.writeFileSync('weatherHour.json', JSON.stringify(weatherMessage));
      } else
        console.log("I don't have the channel");
        return false;
    }).catch(error => {
      console.error("Error: " + error);
      return false;
    });
  }, {
    timezone: "Europe/Paris"
  });
  return true;
}

function checkWeatherDiff() {
    const city = 'rennes';
    const apiKey = process.env.WEATHER_API_KEY;

    axios.get(`http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}`).then(response => {
      const weatherData = response.data;
      const temp = Math.round(weatherData.main.temp - 273.15);
      const condition = weatherData.weather[0].description;

      if (previousWeatherData) {
        const tempDifference = Math.abs(temp - previousWeatherData.temp);
        if (tempDifference >= 5 || condition !== previousWeatherData.condition) {
          const weatherMessage = `Weather in ${city}: ${temp} degrees Celcius, ${condition}`;
          const channel = BotClient.channels.cache.get(process.env.DISCORD_CHANNEL);

          if (channel && channel.isTextBased()) {
            fs.writeFileSync('weatherDiff.json', JSON.stringify(weatherMessage));
          } else
            console.log("I don't have the channel");
            return false;
        }
      }

      previousWeatherData = {
        temp: temp,
        condition: condition,
      };
    }).catch(error => {
      console.error("Error with the axios weather: " + error);
      return false;
    });
    return true;
}

function weatherDiff() {
  cron.schedule('*/30 * * * *', checkWeatherDiff, {
    timezone: "Europe/Paris"
  });
  return true;
}

module.exports = { callActionDiscord };