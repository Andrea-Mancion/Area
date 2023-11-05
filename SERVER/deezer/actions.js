const axios = require('axios');
require('dotenv').config();

async function callActionDeezer(area) {
    const action_Name = area.action_Name;
    if (action_Name == "add_song") {
        add_song(area.action_Param);
    }
}

async function sendPlaylist(access_token_deezer, name_song) {
    try {
        var idSong;

        const response = await axios.get(`https://api.deezer.com/search?q=${name_song}&limit=1&output=json`, {
          headers: {
            'x-api-key': access_token_deezer,
          }
        });

        if (response.status === 200) {
          if (response.data.data[0]) {
            idSong = response.data.data[0].id;
          } else
            console.log("FAILED TO response.data.data[0]");
        } else
          console.log("FAILED TO GET SONG ID");

        const reponse = await axios.post(`https://api.deezer.com/playlist/${process.env.DEEZER_PLAYLIST}/tracks`, {
          params: {
            songs: idSong,
          },
          headers: {
            'Authorization': `Bearer ${access_token_deezer}`,
          },
        });

        if (reponse.status === 200) {
          console.log(reponse);
          console.log("SUCCESS");
        } else
          console.log("FAILED TO ADD SONG TO PLAYLIST");
    } catch (error) {
        console.log("ERROR");
        console.log(error);
    }
}

async function add_song(areaContent) {
    await sendPlaylist(areaContent.access_token, areaContent.name_song);
}

module.exports = { callActionDeezer };