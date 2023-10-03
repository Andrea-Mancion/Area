const express = require('express');
const bodyParser = require('body-parser');
const indexApp = require('./index');
const session = require('express-session');
const { Pool } = require('pg');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth2').Strategy;
const BotClient = require('./myBot.js');
const DiscordStrategy = require('passport-discord').Strategy;
const axios = require('axios');
const cron = require('node-cron');

const GOOGLE_CLIENT_ID = '444052914844-03578lm9fm3qvk5g9od06b089ebepgiq.apps.googleusercontent.com';
const GOOGLE_CLIENT_SECRET = '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';
var userProfile;
const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
const port = process.env.PORT || 3000;
path = require('path');
app.set('view engine', 'ejs'); // Utilisation du moteur de modèle EJS
app.set('views', path.join(__dirname, 'views')); // Dossier où se trouvent les fichiers de vue (views)
// Middleware pour gérer les données POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

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
      clientID: GOOGLE_CLIENT_ID,
      clientSecret: GOOGLE_CLIENT_SECRET,
      callbackURL: "http://localhost:3000/auth/google/callback"
    },
    function(accessToken, refreshToken, profile, done) {
        userProfile=profile;
        console.log(accessToken);
        console.log(profile.id);
        return done(null, userProfile);
    }
  ));

  passport.use(new DiscordStrategy({
      clientID: '1156974898644795393',
      clientSecret: 'X8IKJ1RTnh-QUyfFTTh6N5d1lZoUuSGD',
      callbackURL: "http://localhost:3000/auth/discord/callback",
      scope: ['identify', 'guilds']
    },
    function(accessToken, refreshToken, profile, done) {
      return done(null, profile);
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

  app.get('/auth/discord', passport.authenticate('discord'));

  app.get('/auth/discord/callback',
    passport.authenticate('discord', { failureRedirect: '/auth/error' }),
    function(req, res) {
      res.redirect('/messages');
    });

  app.get('/messages', (req, res) => {
    const channel = BotClient.channels.cache.get('1158325700105863229');
    if (channel && channel.isTextBased()) {
      console.log("I Have the channe");

      channel.messages.fetch().then(messages => {
        const messagesArray = messages.map(message => ({
          author: message.author.tag,
          content: message.content,
        }));
        res.render('pages/messages', { messages: messagesArray });
      }).catch(error => {
        console.error("Error: " + error);
      });
    } else
      console.log("I don't have the channel");
  });

  app.post('/sendMessage', (req, res) => {
    const { message } = req.body;
    const channel = BotClient.channels.cache.get('1158325700105863229');

    if (channel && channel.isTextBased()) {
       channel.send(message).then(() => {
        console.log("Message sent");
        res.redirect('/messages');
       }).catch(error => {
        console.error("Error: " + error);
       });
    } else
      console.log("I don't have the channel");
  });

  cron.schedule('0 10 * * *', () => {
    const city = 'rennes';
    const apiKey = 'd19864bfd5b231d6cf300df7080cbcaa';

    axios.get(`http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}`).then(response => {
      const weatherData = response.data;
      const temp = Math.round(weatherData.main.temp - 273.15);
      const condition = weatherData.weather[0].description;

      const weatherMessage = `Weather in ${city}: ${temp} degrees Celcius, ${condition}`;
      const channel = BotClient.channels.cache.get('1158325700105863229');

      if (channel && channel.isTextBased()) {
        channel.send(weatherMessage).then(() => {
          console.log("Message sent");
        }).catch(error => {
          console.error("Error: " + error);
        });
      } else
        console.log("I don't have the channel");
    }).catch(error => {
      console.error("Error: " + error);
    });
  }, {
    timezone: "Europe/Paris"
  });

  app.get('/weather', (req, res) => {
    const city = 'rennes';
    const apiKey = 'd19864bfd5b231d6cf300df7080cbcaa';

    axios.get(`http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}`).then(response => {
      const weatherData = response.data;
      const temp = Math.round(weatherData.main.temp - 273.15);
      const condition = weatherData.weather[0].description;

      const weatherMessage = `Weather in ${city}: ${temp} degrees Celcius, ${condition}`;
      const channel = BotClient.channels.cache.get('1158325700105863229');

      if (channel && channel.isTextBased()) {
        channel.send(weatherMessage).then(() => {
          console.log("Message sent");
          res.redirect('/messages');
        }).catch(error => {
          console.error("Error: " + error);
        });
      } else
        console.log("I don't have the channel");
    }).catch(error => {
      console.error("Error: " + error);
    });
  });
});

// Démarrer le serveur sur le port 3000
app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});
