const express = require('express');
const bodyParser = require('body-parser');
const indexApp = require('./index');
const session = require('express-session');
const { Pool } = require('pg');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth2').Strategy;

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


// app.get("/createDatabase", (req, res) => {

//     let databaseName = "gfg_db";

//     let createQuery = `CREATE DATABASE ${databaseName}`;

//     // use the query to create a Database.
//     database.query(createQuery, (err) => {
//         if(err) throw err;

//         console.log("Database Created Successfully !");

//         let useQuery = `USE ${databaseName}`;
//         database.query(useQuery, (error) => {
//             if(error) throw error;

//             console.log("Using Database");

//             return res.send(
// `Created and Using ${databaseName} Database`);
//         })
//     });
// });

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

  app.get('/auth/google',
    passport.authenticate('google', { scope : ['profile', 'email'] }));

  app.get('/auth/google/callback',
    passport.authenticate('google', { failureRedirect: '/auth/error' }),
    function(req, res) {
      // Successful authentication, redirect success.
      res.redirect('/auth/success');
    });
});

// Démarrer le serveur sur le port 3000
app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});
