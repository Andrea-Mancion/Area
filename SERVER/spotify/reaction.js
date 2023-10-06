const express = require('express');
const { URLSearchParams } = require('url');
const fetch = require('node-fetch');
const crypto = require('crypto');
const { info } = require('console');
const { accessSync } = require('fs');

let nbEpisode = -1;
const app = express();
const port = 3000; // Le port sur lequel le serveur Express écoutera

let codeVerifier = generateCodeVerifier(128);; // Variable globale pour stocker le code vérificateur
app.set('view engine', 'ejs');
const show = "6y1PloEyNsCNJH9vHias4T";

app.get('/callback', async (req, res) => {
    const clientId = "fdbe5e5dbe5c42b680efb3ab1d3574af";
    const code = req.query.code;

    if (!code) {
        redirectToAuthCodeFlow(clientId, res);
    } else {
        try {
            getAccessToken(clientId, code).then((accessToken) => {
                // startSong(accessToken, show);
                // setVolume(accessToken, 0);
                // addTrackToQueue(accessToken, "spotify:track:7ETSUd74fhHvG2JldNVizV");
                // addItemsToPlaylist(accessToken, "4G0RZx6TlXycJ82b8MQ18C", "spotify:track:7ETSUd74fhHvG2JldNVizV");
                createPlaylist(accessToken, "test2", "test", true, "moi");
            });
        } catch (error) {
            console.error(error);
            res.status(500).send('Erreur lors de la récupération du profil');
        }
    }
});


app.get('/create_playlist', async (req, res) => {
    const accessToken = req.query.accessToken;
    const name = req.query.name;
    const description = req.query.description;
    const public = req.query.public;
    fetch("https://api.spotify.com/v1/me", {
        method: "GET",
        headers: { Authorization: `Bearer ${accessToken}` }
    }).then((result) => {
        result.json().then((data) => {
            if (data.error) {
                console.error(data.error);
                res.sendStatus(500);
                return;
            }
            fetch("https://api.spotify.com/v1/users/" + data.id + "/playlists", {
                method: "POST", headers: { Authorization: `Bearer ${accessToken}` },
                body: JSON.stringify({
                    "name": name,
                    "description": description,
                    "public": public
                })
            }).then((result) => {
                result.json().then((data) => {
                    if (data.error) {
                        console.error(data.error);
                        res.sendStatus(500);
                        return;
                    }
                    res.sendStatus(200);
                    console.log("result", data);
                });
            })
        });
    });
});


app.get('/add_items_to_playlist', async (req, res) => {
    const accessToken = req.query.accessToken;
    const playlistId = req.query.playlistId;
    const trackId = req.query.trackId;
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
            console.log("result", data);
        });
    })
});

// async function addTrackToQueue(accessToken, trackId) {
app.get('/add_track_to_queue', async (req, res) => {
    const accessToken = req.query.accessToken;
    const trackId = req.query.trackId;
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
});

// async function setVolume(accessToken, volume) {
app.get('/set_volume', async (req, res) => {
    const accessToken = req.query.accessToken;
    const volume = req.query.volume;
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
});

// async function startSong(accessToken) {
app.get('/start_song', async (req, res) => {
    const accessToken = req.query.accessToken;
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
});

// async function pauseSong(accessToken) {
app.get('/pause_song', async (req, res) => {
    const accessToken = req.query.accessToken;
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
});

// async function nextSong(accessToken) {
app.get('/next_song', async (req, res) => {
    const accessToken = req.query.accessToken;
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
});

// async function previousSong(accessToken) {
app.get('/previous_song', async (req, res) => {
    const accessToken = req.query.accessToken;
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
});
// data.devices[0].id;

app.listen(port, () => {
    console.log(`Serveur Express écoutant sur le port ${port}`);
});
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