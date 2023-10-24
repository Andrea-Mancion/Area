const express = require('express');
const { URLSearchParams } = require('url');
const fetch = require('node-fetch');
const crypto = require('crypto');
const { info, error } = require('console');
const { get } = require('http');
const session = require('express-session');
const { access } = require('fs');
const { callReaction } = require('./reaction');
const { json } = require('body-parser');

let spotifyVariables = [{
    nbTrack: -1
}];

let nbreact = 0;

function addNewVariables() {
    spotifyVariables.push({
        nbTrack: -1
    });
    nbreact++;
}

const app = express();
const port = 3000; // Le port sur lequel le serveur Express écoutera



let isThereNewSavedTrack = false;


async function callActionSpotify(area, nbReact, reaction_map) {
    const action_Name = area.action_Name;
    console.log(action_Name);
    if (action_Name == "check_new_saved_track") {
        // let nbTrack = jsonparse(spotifyVariables.nbTrack);
        const newTrack = await checkNewSavedTrack(area.action_access_token, nbReact);
        if (newTrack) {
            await reaction_map[area.reaction_service_Name](area);
        }
    }
    if (action_Name == "check_new_episode") {
        const newEpisode = await checkNewEpisode(area.action_access_token, area.action_Param);
        if (newEpisode) {
            await reaction_map[area.reaction_service_Name](area);
        }
    }
}

async function checkNewSavedTrack(accessToken, nbReact) {
    const infoTrack = await fetchTrack(accessToken);
    if (infoTrack.error) {
        console.error(infoTrack.error);
        console.log("Erreur lors de la récupération du profil");
        // throw error;
        return false;
    }
    if (spotifyVariables[nbReact].nbTrack == -1) {
        spotifyVariables[nbReact].nbTrack = infoTrack.total;
        console.log("Pas de nouveau morceau");
        return false;
    } else {
        if (infoTrack.total > spotifyVariables[nbReact].nbTrack) {
            console.log("Nouveau morceau");
            spotifyVariables[nbReact].nbTrack = infoTrack.total;
            // isThereNewSavedTrack = true;
            return true;
        } else if (infoTrack.total < spotifyVariables[nbReact].nbTrack) {
            spotifyVariables[nbReact].nbTrack = infoTrack.total;
            return false;
        }
        else {
            console.log("Pas de nouveau morceau");
            return false;
        }
    }
}

async function checkNewEpisode(accessToken, ShowId) {
    const infoShow = await fetchShow(accessToken, ShowId);
    if (infoShow.error) {
        console.error(infoShow.error);
        throw error;
    }
    if (nbEpisode == -1) {
        nbEpisode = infoShow.total;
        return false;
    } else {
        if (infoShow.total > nbEpisode) {
            console.log("Nouvel épisode");
            return true;
        }
        else {
            console.log("Pas de nouvel épisode");
            return false;
        }
    }
}

async function fetchShow(token, nameShow) {
    const result = await fetch("https://api.spotify.com/v1/shows/" + nameShow + "/episodes", {
        method: "GET", headers: { Authorization: `Bearer ${token}` }
    });

    return await result.json();
}

async function fetchTrack(token) {
    const result = await fetch("https://api.spotify.com/v1/me/tracks", {
        method: "GET", headers: { Authorization: `Bearer ${token}` }
    });

    return await result.json();
}

module.exports = { callActionSpotify, addNewVariables, nbreact};
