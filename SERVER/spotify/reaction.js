const express = require('express');
const { URLSearchParams } = require('url');
const fetch = require('node-fetch');
const crypto = require('crypto');
const { info } = require('console');
const { accessSync } = require('fs');
const { create } = require('domain');

let nbEpisode = -1;
const app = express();
const port = 3000; // Le port sur lequel le serveur Express écoutera

reaction_map = new Map();

async function callReaction(area) { // to replace
    const reaction_Name = area.reaction_Name;
    const reaction_Param = area.reaction_Param;
    const accessToken = area.reaction_access_token;
    if (reaction_Name == "createPlaylist") {
        await createPlaylist(accessToken, reaction_Param.name, reaction_Param.description, reaction_Param.is_public);
    }
    if (reaction_Name == "add_items_to_playlist") {
        await add_items_to_playlist(accessToken, reaction_Param.playlistId, reaction_Param.trackId);
    }
    if (reaction_Name == "addTrackToQueue") {
        await addTrackToQueue(accessToken, reaction_Param.trackId);
    }
    if (reaction_Name == "setVolume") {
        await setVolume(accessToken, reaction_Param.volume);
    }
    if (reaction_Name == "startSong") {
        await startSong(accessToken);
    }
    if (reaction_Name == "pauseSong") {
        await pauseSong(accessToken);
    }
    if (reaction_Name == "nextSong") {
        nextSong(accessToken);
    }
    if (reaction_Name == "previousSong") {
        await previousSong(accessToken);
    }
    return;
}

module.exports = { callReaction };

async function createPlaylist(accessToken, name, description, is_public) {
    fetch("https://api.spotify.com/v1/me", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
            fetch("https://api.spotify.com/v1/users/" + data.id + "/playlists", {
                method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "name": name,
                    "description": description,
                    "public": is_public
                })
            }).then((result) => {
                result.json().then((data) => {
                    if (data.error) {
                        console.error(data.error);
                        return;
                    }
                });
            })
        });
    });
};


async function add_items_to_playlist(accessToken, playlistId, trackId) {
    fetch("https://api.spotify.com/v1/playlists/" + playlistId + "/tracks", {
        method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
        body: JSON.stringify({
            "uris": [trackId]
        })
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
        });
    })
};

// app.get('/add_track_to_queue', async (req, res) => {
async function addTrackToQueue(accessToken, trackId) {
    fetch("https://api.spotify.com/v1/me/player/devices", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
            console.log("data: ", data.devices[0].id);
            fetch("https://api.spotify.com/v1/me/player/queue", {
                method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "device_id": data.devices[0].id,
                    "uri": trackId
                })
            }).then((result) => {
                result.json().then((data) => {
                    console.log("result", data);
                });
            }
            )
            console.log("result", data);
        });
    });
};

// app.get('/set_volume', async (req, res) => {
async function setVolume(accessToken, volume) {
    fetch("https://api.spotify.com/v1/me/player/devices", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
            console.log("data: ", data.devices[0].id);
            fetch("https://api.spotify.com/v1/me/player/volume", {
                method: "PUT", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "device_id": data.devices[0].id,
                    "volume_percent": volume
                })
            }).then((result) => {
                result.json().then((data) => {
                    console.log("result", data);
                });
            })
            console.log("result", data);
        });
    });
};

async function startSong(accessToken) {
    fetch("https://api.spotify.com/v1/me/player/devices", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
            console.log("data: ", data.devices[0].id);
            fetch("https://api.spotify.com/v1/me/player/next", {
                method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "device_id": data.devices[0].id,
                    "play": true
                })
            }).then((result) => {
                result.json().then((data) => {
                    console.log("result", data);
                });
            }
            )
            console.log("result", data);
        });
    });
};

async function pauseSong(accessToken) {
    fetch("https://api.spotify.com/v1/me/player/devices", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
            console.log("data: ", data.devices[0].id);
            fetch("https://api.spotify.com/v1/me/player/pause", {
                method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "device_id": data.devices[0].id,
                    "play": true
                })
            }).then((result) => {
                result.json().then((data) => {
                    console.log("result", data);
                });
            }
            )
            console.log("result", data);
        });
    });
};

async function nextSong(accessToken) {
    fetch("https://api.spotify.com/v1/me/player/devices", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
            console.log("data: ", data.devices[0].id);
            fetch("https://api.spotify.com/v1/me/player/next", {
                method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "device_id": data.devices[0].id,
                    "play": true
                })
            }).then((result) => {
                result.json().then((data) => {
                    console.log("result", data);
                });
            }
            )
            console.log("result", data);
        });
    });
};

async function previousSong(accessToken) {
    fetch("https://api.spotify.com/v1/me/player/devices", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                return;
            }
            console.log("data: ", data.devices[0].id);
            fetch("https://api.spotify.com/v1/me/player/previous", {
                method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "device_id": data.devices[0].id,
                    "play": true
                })
            }).then((result) => {
                result.json().then((data) => {
                    console.log("result", data);
                });
            }
            )
            console.log("result", data);
        });
    });
};
// data.devices[0].id;

/*
async function redirectToAuthCodeFlow(clientId, res) {
    codeVerifier = generateCodeVerifier(128); // Stocker le code vérificateur dans la variable globale
    const challenge = await generateCodeChallenge(codeVerifier);

    const params = new URLSearchParams();
    params.append("client_id", clientId);
    params.append("response_type", "code");
    params.append("redirect_uri", "http://localhost:3000/callback");
    params.append("scope", "user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public");
    params.append("code_challenge_method", "S256");
    params.append("code_challenge", challenge);

    // Rediriger vers l'URL d'autorisation
    const authorizationUrl = `https://accounts.spotify.com/authorize?${params.toString()}`;
    res.redirect(authorizationUrl);
}
function generateCodeVerifier(length) {
    let text = '';
    let possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    for (let i = 0; i < length; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}
async function generateCodeChallenge(codeVerifier) {
    const encoder = new TextEncoder();
    const data = encoder.encode(codeVerifier);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));

    // Convertir le tableau d'octets en chaîne base64 URL-safe
    const base64 = btoa(hashArray.map(byte => String.fromCharCode(byte)).join(''));
    const base64UrlSafe = base64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');

    return base64UrlSafe;
}

async function getAccessToken(clientId, code) {
    const params = new URLSearchParams();
    params.append("client_id", clientId);
    params.append("grant_type", "authorization_code");
    params.append("code", code);
    params.append("redirect_uri", "http://localhost:3000/callback");
    params.append("scope", "user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public");
    //it miss the verifier
    params.append("code_verifier", codeVerifier);

    const result = await fetch("https://accounts.spotify.com/api/token", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },

        body: params
    });

    const { access_token } = await result.json();
    return access_token;
}
*/
