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
const { callActionDeezer } = require('./deezer/actions.js');
const cors = require('cors');
const { verify } = require('crypto');
let { callActionDiscord } = require('./discord/actions.js');
const { callReactionDiscord } = require('./discord/reactions.js');
const { callActionGithub } = require('./github/actions.js');
const BotClient = require('./discord/myBot.js');
const { callActiondailymotion } = require('./dailymotion/action.js');
const { callReactiondailymotion } = require('./dailymotion/reaction.js')
const { callActionDropbox } = require('./dropbox/action.js');
const DiscordStrategy = require('passport-discord').Strategy;
const cron = require('node-cron');
const { time } = require('console');
const fs = require('fs');

var userProfile;
let previousWeatherData = null;
const axios = require('axios');
const { token } = require('morgan');
let { callActionTwitch } = require('./twitch/actions.js');
const { callReactionTwitch } = require('./twitch/reactions.js');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
const port = process.env.PORT || 8080;
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

// Page de succès (vous pouvez créer cette page selon vos besoins)
app.get('/success', (req, res) => {
  app.use(session({
    resave: false,
    saveUninitialized: true,
    secret: 'SECRET'
  }));
  res.render('pages/auth');
  const passport = require('passport');
  var userProfile;
  var my_access_token
  var my_refresh_token
  var recup_Total;

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
    callbackURL: "http://localhost:8080/auth/google/callback"
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
});

const action_map = {
  'Spotify': callActionSpotify,
  'Discord': callActionDiscord,
  'Deezer': callActionDeezer,
  'Github': callActionGithub,
  'Twitch': callActionTwitch,
  'dailymotion': callActiondailymotion,
  'Dropbox': callActionDropbox,
}

const reaction_map = {
  'Spotify': spotify_reaction,
  'Discord': callReactionDiscord,
  'Twitch': callReactionTwitch,
  'dailymotion': callReactiondailymotion,
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
  res.status(200).json(about);
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


app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});
