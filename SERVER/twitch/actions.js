const axios = require('axios');
const { callReactionTwitch } = require('./reactions');
require('dotenv').config();

var counter = 0;
var recup_Total;

async function callActionTwitch(area) {
    const action_Name = area.action_Name;
    if (action_Name == "check_new_follow") {
        if (check_new_follow(area.action_Param))
            await callReactionTwitch(area);
    }
}

async function getFollowedChannel(access_token_twitch) {
    try {
      var user_id_twitch;
      const userURL = 'https://api.twitch.tv/helix/users';
      const headers = {
        'Client-ID': process.env.TWITCH_CLIENT,
        'Authorization': `Bearer ${access_token_twitch}`,
      };
      const response = await axios.get(userURL, { headers });

      if (response.status === 200) {
        user_id_twitch = response.data.data[0].id;
      } else {
        console.log("FAILED");
      }

      const reponse = await axios.create({
        baseURL: 'https://api.twitch.tv/helix',
        headers: {
          'Client-ID': process.env.TWITCH_CLIENT,
          'Authorization': `Bearer ${access_token_twitch}`,
        },
      }).get('/channels/followed', {
        params: {
          user_id: user_id_twitch,
        },
      });
      counter = counter + 1;
      return reponse.data;
    } catch(error) {
      console.log("ERROR GETTING FOLLOWED CHANNELS");
      console.log(error);
    }
}

async function check_new_follow(areaContent) {
    const test = await getFollowedChannel(areaContent.access_token);
    if (counter === 1) {
        recup_Total = test.total;
    } else {
        if (recup_Total < test.total) {
            console.log("NOUVEAU FOLLOW");
            recup_Total = test.total;
        } else
            console.log("PAS DE NOUVEAU FOLLOW");
    }
}

module.exports = { callActionTwitch };