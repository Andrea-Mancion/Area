const express = require('express');
const bodyParser = require('body-parser');
const indexApp = require('./index');
const session = require('express-session');
const { Pool } = require('pg');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth2').Strategy;
const axios = require('axios');
const { token } = require('morgan');
let { callActionTwitch } = require('./twitch/actions.js');
const { callReactionTwitch } = require('./twitch/reactions.js');
const { EXTERNAL_ACCOUNT_AUTHORIZED_USER_TYPE } = require('google-auth-library/build/src/auth/externalAccountAuthorizedUserClient');
require('dotenv').config();

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
const port = process.env.PORT || 3000;
path = require('path');
app.set('view engine', 'ejs'); // Utilisation du moteur de modèle EJS
app.set('views', path.join(__dirname, 'views')); // Dossier où se trouvent les fichiers de vue (views)
// Middleware pour gérer les données POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
var access_token_twitch;
var counter = 0;
var broadcast_id;

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

  pool.connect()
    .then(client => {
      return client.query('INSERT INTO users (username, password) VALUES ($1, $2)', [username, password])
        .then(result => {
          console.log('User registered successfully!');
          client.release(); // Release the client connection
          res.redirect('/success');
        })
        .catch(err => {
          console.error('Error registering user: ' + err.message);
          client.release(); // Release the client connection
          res.status(500).json({ error: 'Error registering user' });
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
            client.release(); // Release the client connection
            res.redirect('/success');
          } else {
            console.log('Authentication failed: incorrect username or password');
            client.release(); // Release the client connection
            res.status(401).json({ error: 'Incorrect username or password' });
          }
        })
        .catch(err => {
          console.error('Error during authentication: ' + err.message);
          client.release(); // Release the client connection
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

  passport.serializeUser(function(user, cb) {
    cb(null, user);
  });

  passport.deserializeUser(function(obj, cb) {
    cb(null, obj);
  });

  passport.use(new GoogleStrategy({
      clientID: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      callbackURL: "http://localhost:3000/auth/google/callback",
      scope: ['profile', 'email', 'https://www.googleapis.com/auth/gmail.readonly'],
    },
    function(accessToken, refreshToken, profile, done) {
        userProfile=profile;
        my_access_token = accessToken;
        my_refresh_token = refreshToken;
        return done(null, userProfile);
    }
  ));

  app.get('/auth/google',
    passport.authenticate('google', { scope : ['profile', 'email'] }));

  app.get('/auth/google/callback',
    passport.authenticate('google', { failureRedirect: '/auth/error' }),
    function(req, res) {
      // Successful authentication, redirect success.
      res.redirect('/auth/success');
    });

  const action_map = {
    'Twitch': callActionTwitch,
  }

  const reaction_map = {
    'Twitch': callReactionTwitch,
  }

  app.get('/auth/twitch', (req, res) => {
    const twitchURL = `https://id.twitch.tv/oauth2/authorize?client_id=${process.env.TWITCH_CLIENT}&redirect_uri=http://localhost:3000/auth/twitch/callback&response_type=code&scope=user:read:email user:read:follows moderator:read:followers`;
    res.redirect(twitchURL);
  });

  app.get('/auth/twitch/callback', (req, res) => {
    const code = req.query.code;
    const tokenURL = 'https://id.twitch.tv/oauth2/token';

    const data = {
      client_id: process.env.TWITCH_CLIENT,
      client_secret: process.env.TWITCH_SECRET,
      code,
      grant_type: 'authorization_code',
      redirect_uri: 'http://localhost:3000/auth/twitch/callback',
    };

    axios.post(tokenURL, data).then((response) => {
      if (response.status === 200) {
        access_token_twitch = response.data.access_token;

        console.log("OKKK");
        res.render('auth/successTwitch');
      } else
        res.redirect('/auth/error');
    }).catch((error) => {
      console.log("NOOOOO");
      console.log(error);
    });
  });

  app.get('/getNew', async (req, res) => {
    console.log("OKLKKKKNBGFJVHKCT");
  });
});

// Démarrer le serveur sur le port 3000
app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});
