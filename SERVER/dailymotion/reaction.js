
const express = require('express');

async function callReactiondailymotion(area)
{
    if (area.reaction_Name == "create_playlist")
        createPlaylist(area);
}

async function createPlaylist(area)
{
    let access_token = area.reaction_access_token;
    let playlist_name = area.reaction_Param.playlist_name;
    let playlist_description = area.reaction_Param.playlist_description;
    let playlist_privacy = area.reaction_Param.playlist_privacy;

    fetch('https://api.dailymotion.com/me/playlists?access_token=' + access_token + '&name=' + playlist_name + '&description=' + playlist_description + '&privacy=' + playlist_privacy, {
        method: 'POST',
        headers: {
            Authorization: `Bearer ${access_token}`
        },
    })
}

module.exports = {callReactiondailymotion};