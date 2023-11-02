const express = require('express');
const bodyParser = require('body-parser');
const indexApp = require('./index');
const session = require('express-session');
const { Pool } = require('pg');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth2').Strategy;
const { access } = require('fs');
let { callActionSpotify, addNewVariables, nbreact } = require('./spotify/action.js');
const { spotify_reaction } = require('./spotify/reaction.js');
const cors = require('cors');
const { verify } = require('crypto');
let { callActionDiscord } = require('./discord/actions.js');
const { callReactionDiscord } = require('./discord/reactions.js');
const BotClient = require('./discord/myBot.js');
const DiscordStrategy = require('passport-discord').Strategy;
const axios = require('axios');
const cron = require('node-cron');
const { time } = require('console');
const crypto = require('crypto');
require('dotenv').config();
const fs = require('fs');

var userProfile;
let previousWeatherData = null;
var access_token_deezer;
const app = express();
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
const port = process.env.PORT || 3000;
path = require('path');
app.set('view engine', 'ejs'); // Utilisation du moteur de modèle EJS
app.set('views', path.join(__dirname, 'views')); // Dossier où se trouvent les fichiers de vue (views)
// Middleware pour gérer les données POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
let area = [];
// Route pour l'inscription (register)
app.get('/register', (req, res) => {
  res.render('register'); // Utilisez res.render pour afficher la page EJS (assurez-vous que 'login.ejs' existe dans le dossier 'views')
});

app.get('/login', (req, res) => {
  res.render('login'); // Utilisez res.render pour afficher la page EJS (assurez-vous que 'login.ejs' existe dans le dossier 'views')
});

const pool = new Pool({
  host: 'db',
  user: 'Ferius',
  password: 'Ferius1901',
  database: 'gfg_db',
  port: 5432,
});


// Route pour l'inscription (register)
app.post('/register', (req, res) => {
  const { username, password } = req.body;

  console.log("====================================");
  console.log(username);
  console.log(password);

  pool.connect()
    .then(client => {
      client.query('INSERT INTO users (username, password) VALUES ($1, $2)', [username, password])
        .then(result => {
          if (!result.error) {
            console.log(result);
            console.log('User registered successfully!');
            res.sendStatus(200);
          }
          else {
            console.log('Error registering user');
            res.status(400).json({ error: 'Error registering user' });
          }
        })
        .catch(err => {
          console.error('Error registering user: ' + err.message);
          res.status(400).json({ error: 'Error registering user' });
        });
    })
    .catch(err => {
      console.error('Error getting database connection: ' + err.message);
      res.status(500).json({ error: 'Error getting database connection' });
    });
});

// Route pour l'authentification (login)
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  pool.connect()
    .then(client => {
      return client.query('SELECT * FROM users WHERE username = $1 AND password = $2', [username, password])
        .then(results => {
          if (results.rows.length > 0) {
            console.log('Authentication successful!');
            res.status(200).json({ success: 'Authentication successful' });
            //client.release(); // Release the client connection
          } else {
            console.log('Authentication failed: incorrect username or password');
            res.status(401).json({ error: 'Incorrect username or password' });
          }
        })
        .catch(err => {
          console.error('Error during authentication: ' + err.message);
          res.status(500).json({ error: 'Error during authentication' });
        });
    })
    .catch(err => {
      console.error('Error getting database connection: ' + err.message);
      res.status(500).json({ error: 'Error getting database connection' });
    });
});

async function sendPlaylist() {
  try {
    const nameSong = "Je m'excuse";
    var idSong;

    const response = await axios.get(`https://api.deezer.com/search?q=${nameSong}&limit=1&output=json`, {
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

    const reponse = await axios.post(`https://api.deezer.com/playlist/${process.env.DEEZER_PLAYLIST}/tracks`, null, {
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

// Page de succès (vous pouvez créer cette page selon vos besoins)
app.get('/success', (req, res) => {
  app.use(session({
    resave: false,
    saveUninitialized: true,
    secret: 'SECRET'
  }));
  res.render('pages/auth');

  app.use(passport.initialize());
  app.use(passport.session());

  app.set('view engine', 'ejs');

  app.get('/auth/success', (req, res) => res.render('auth/success', { user: userProfile }));
  app.get('/auth/error', (req, res) => res.send("error logging in"));

  passport.serializeUser(function (user, cb) {
    cb(null, user);
  });

  passport.deserializeUser(function (obj, cb) {
    cb(null, obj);
  });

  passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: "http://localhost:3000/auth/google/callback"
  },
    function (accessToken, refreshToken, profile, done) {
      userProfile = profile;
      console.log(accessToken);
      console.log(profile.id);
      return done(null, userProfile);
    }
  ));

  // passport.use(new DiscordStrategy({
  //     clientID: process.env.DISCORD_CLIENT_ID,
  //     clientSecret: process.env.DISCORD_CLIENT_SECRET,
  //     callbackURL: "http://localhost:3000/auth/discord/callback",
  //     scope: ['identify', 'guilds']
  //   },
  //   function(accessToken, refreshToken, profile, done) {
  //     return done(null, profile);
  //   }
  // ));

  app.get('/auth/google',
    passport.authenticate('google', { scope: ['profile', 'email'] }));

  app.get('/auth/google/callback',
    passport.authenticate('google', { failureRedirect: '/auth/error' }),
    function (req, res) {
      // Successful authentication, redirect success.
      res.redirect('/auth/success');
    });

  app.get('/getReset', async (req, res) => {
    const response = await axios.get('https://api.deezer.com/user/me', {
      headers: {
        'Authorization': `Bearer ${access_token_deezer}`,
      },
    });

    if (response.status === 200) {
      console.log("RESSEEEEEEEET");
      console .log(response.data);
    } else {
      console.log("FAILED TO RESET");
    }
    const state = crypto.randomBytes(32).toString('hex');
    req.session.oauthState = state;
    const deezerURL = `https://connect.deezer.com/oauth/auth.php?app_id=${process.env.DEEZER_ID}&redirect_uri=http://localhost:3000/auth/deezer/callback&perms=basic_access,email,manage_library,manage_community&state=${state}`;
    res.redirect(deezerURL);
  });

  app.get('/auth/deezer', (req, res) => {
    const state = crypto.randomBytes(32).toString('hex');
    req.session.oauthState = state;
    const deezerURL = `https://connect.deezer.com/oauth/auth.php?app_id=${process.env.DEEZER_ID}&redirect_uri=http://localhost:3000/auth/deezer/callback&perms=basic_access,email,manage_library,manage_community&state=${state}`;
    res.redirect(deezerURL);
  });

  app.get('/auth/deezer/callback', (req, res) => {
     const code = req.query.code;
     const tokenURL = 'https://connect.deezer.com/oauth/access_token.php';

     const data = {
        app_id: process.env.DEEZER_ID,
        secret: process.env.DEEZER_SECRET,
        code,
     };

     axios.post(tokenURL, null, { params: data }).then((response) => {
      if (response.status === 200) {
        console.log(response.data);
        access_token_deezer = response.data.match(/access_token=([^&]+)/)[1];
        res.render('auth/successDeezer');
      } else
        res.redirect('/auth/error');
     }).catch((error) => {
        console.log("ERRRRRRRRROOOOEOEOEOEOEOEO deezEER");
        console.log(error);
     });
  });

  app.get('/getNew', async (req, res) => {
    await sendPlaylist();
    console.log("HHHHDHDDHDHDH");
  });
});

const action_map = {
  'Spotify': callActionSpotify,
  'Discord': callActionDiscord,
}

const reaction_map = {
  'Spotify': spotify_reaction,
  'Discord': callReactionDiscord,
}

app.get("/about.json", (req, res) => {
  services = [];
  //check all folder to see if there is a about.json file and if there is, add it to the array
  fs.readdirSync('./').forEach(file => {
    if (fs.existsSync('./' + file + '/about.json')) {
      services.push(require('./' + file + '/about.json'));
    }
  });
  // host_ip  indicates the IP address of the client performing the HTTP request
  host_ip = req.header('x-forwarded-for') || req.socket.remoteAddress;
  about = {
    "client": {
      "host": host_ip,
    },
    "server": {
      "current_time": Date.now(),
      "services": services
    }
  };
  res.send(about);
});

function verify_variable(area) {
  if (area.length == 0) {
    console.log("size");
    return false;
  }
  if (area.action_service_Name == "" || area.reaction_service_Name == "" || area.action_Name == "" || area.reaction_Param == "" || area.access_token == "" || area.user_id == "") {
    if (area.action_service_Name == "") {
      console.log("action_service_Name");
    }
    if (area.reaction_service_Name == "") {
      console.log("reaction_service_Name");
    }
    if (area.action_Name == "") {
      console.log("action_Name");
    }
    if (area.reaction_Param == "") {
      console.log("reaction_Param");
    }
    if (area.access_token == "") {
      console.log("access_token");
    }
    if (area.user_id == "") {
      console.log("user_id");
    }
    return false;
  }
  return true;
}

app.post('/create_action', (req, res) => {
  const {
    action_service_Name,
    reaction_service_Name,
    action_Name,
    reaction_Name,
    action_Param,
    reaction_Param,
    action_access_token,
    reaction_access_token,
    user_id
  } = req.body;

  // Créez un nouvel objet pour chaque entrée et ajoutez-le au tableau
  const newAreaObject = {
    action_service_Name,
    reaction_service_Name,
    action_Name,
    reaction_Name,
    action_Param,
    reaction_Param,
    action_access_token,
    reaction_access_token,
    user_id
  };
  area.push(newAreaObject);
  console.log(area);
  addNewVariables();
  if (!verify_variable(newAreaObject)) {
    res.status(400).json({ error: 'Error creating action' });
    return;
  }
  setInterval(() => action_map[action_service_Name](newAreaObject, nbreact, reaction_map), 3000);
  nbreact++;

  /*
    pool.connect()
      .then(client => {
        return client.query('INSERT INTO actions (action_Name, reaction_Name, action_Param, reaction_Param) VALUES ($1, $2, $3, $4)', [action_Name, reaction_Name, action_Param, reaction_Param])
          .then(result => {
            console.log('Action created successfully!');
            client.release(); // Release the client connection
            res.redirect('/success');
          })
          .catch(err => {
            console.error('Error creating action: ' + err.message);
            client.release(); // Release the client connection
            res.status(500).json({ error: 'Error creating action' });
          });
      })
      .catch(err => {
        console.error('Error getting database connection: ' + err.message);
        res.status(500).json({ error: 'Error getting database connection' });
      });
  */
});


// Démarrer le serveur sur le port 3000
app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});
