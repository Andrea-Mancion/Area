const express = require('express');
const { URLSearchParams } = require('url');
const fetch = require('node-fetch');
const crypto = require('crypto');
const { info, error } = require('console');
const { get } = require('http');
const session = require('express-session');
const { access } = require('fs');
const { callReaction } = require('./reaction');
// const generateCodeVerifier = require('reaction');
//import generateCodeVerifier function from server.js


let nbEpisode = -1;
let nbTrack = -1;
const app = express();
const port = 3000; // Le port sur lequel le serveur Express écoutera

let codeVerifier = generateCodeVerifier(128); // Variable globale pour stocker le code vérificateur

let isThereNewSavedTrack = false;

// app.get('/create_action_saved_track', async (req, res) => {
//     const clientId = "fdbe5e5dbe5c42b680efb3ab1d3574af";
//     const code = req.query.code;
//         try {
//             const accessToken = await getAccessToken(clientId, code, 'create_action_saved_track');

//             // Stockez le token d'accès dans la session
//             req.session.accessToken = accessToken;
//             setInterval(() => checkNewSavedTrack(req.session.accessToken), 3000);
//             //ecrir dands base de donnée
//             res.sendStatus(200);
//         } catch (error) {
//             console.error(error);
//             res.status(500).send('Erreur lors de la récupération du profil');
//         }
// });

// app.get("/check_new_saved_track", async (req, res) => {
//     if (isThereNewSavedTrack) {
//         res.sendStatus(200);
//         isThereNewSavedTrack = false;
//     } else {
//         res.sendStatus(500);
//     }
// });


// app.get('/check_new_saved_track', async (req, res) => {

//     const accessToken = req.query.accessToken;
//     try {
//         const newTrack = await checkNewSavedTrack(accessToken);
//         if (newTrack) {
//             res.sendStatus(200);
//         } else {
//             res.sendStatus(900);
//         }
//     } catch (error) {
//         console.error(error);
//         res.status(500).send('Erreur lors de la récupération du profil');
//     }
// });

// callAction = async (area) => {
async function callAction(area) {
    const action_Name = area.action_Name;
    if (action_Name == "check_new_saved_track") {
        const newTrack = await checkNewSavedTrack(area.access_token);
        if (newTrack) {
            callReaction(area);
        }
    }
    if (action_Name == "check_new_episode") {
        const newEpisode = await checkNewEpisode(area.access_token, area.action_Param);
        if (newEpisode) {
            callReaction(area);
        }
    }
}

async function checkNewSavedTrack(accessToken) {
    if (isThereNewSavedTrack)
        return;
    const infoTrack = await fetchTrack(accessToken);
    if (infoTrack.error) {
        console.error(infoTrack.error);
        // throw error;
        return false;
    }
    if (nbTrack == -1) {
        nbTrack = infoTrack.total;
        return false;
    } else {
        if (infoTrack.total > nbTrack) {
            console.log("Nouveau morceau");
            nbTrack = infoTrack.total;
            isThereNewSavedTrack = true;
            return true;
        } else if (infoTrack.total < nbTrack) {
            nbTrack = infoTrack.total;
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


function generateCodeVerifier(length) {
    let text = '';
    let possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    for (let i = 0; i < length; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
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

module.exports = {app, callAction};