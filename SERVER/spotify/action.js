const express = require('express');
const { URLSearchParams } = require('url');
const fetch = require('node-fetch');
const crypto = require('crypto');
const { info, error } = require('console');
const { get } = require('http');
const session = require('express-session');
const { access } = require('fs');

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


app.get('/check_new_saved_track', async (req, res) => {

    const accessToken = req.query.accessToken;
    try {
        const newTrack = await checkNewSavedTrack(accessToken);
        if (newTrack) {
            res.sendStatus(200);
        } else {
            res.sendStatus(900);
        }
    } catch (error) {
        console.error(error);
        res.status(500).send('Erreur lors de la récupération du profil');
    }
});

app.listen(port, () => {
    console.log(`Serveur Express écoutant sur le port ${port}`);
});



checkNewSavedTrack = async (accessToken) => {
    if (isThereNewSavedTrack)
        return;
    const infoTrack = await fetchTrack(accessToken);
    if (infoTrack.error) {
        console.error(infoTrack.error);
        // throw error;
        return;
    }
    if (nbTrack == -1) {
        nbTrack = infoTrack.total;
    } else {
        if (infoTrack.total > nbTrack) {
            console.log("Nouveau morceau");
            nbTrack = infoTrack.total;
            isThereNewSavedTrack = true;
        } else if (infoTrack.total < nbTrack) {
            nbTrack = infoTrack.total;
        }
        else {
            console.log("Pas de nouveau morceau");
            return;
        }
    }
}

app.get('/check_new_episode', async (req, res) => {
    accessToken = req.query.accessToken;

    try {
        checkNewEpisode(accessToken, show).then((newEpisode) => {
            if (newEpisode) {
                res.sendStatus(200);
            }
            else {
                res.sendStatus(400);
            }
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Erreur lors de la récupération du profil');
    }
});

async function checkNewEpisode(accessToken, nameShow) {
    const infoShow = await fetchShow(accessToken, nameShow);
    if (infoShow.error) {
        console.error(infoShow.error);
        throw error;
    }
    if (nbEpisode == -1) {
        nbEpisode = infoShow.total;
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

