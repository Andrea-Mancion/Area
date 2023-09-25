const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const database = require('./sqlConnection');
const indexApp = require('./index');
const session = require('express-session');

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
const port = process.env.PORT || 3000;
path = require('path');
app.set('view engine', 'ejs'); // Utilisation du moteur de modèle EJS
app.set('views', path.join(__dirname, 'views')); // Dossier où se trouvent les fichiers de vue (views)
// Middleware pour gérer les données POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


app.get("/createDatabase", (req, res) => {

    let databaseName = "gfg_db";

    let createQuery = `CREATE DATABASE ${databaseName}`;

    // use the query to create a Database.
    database.query(createQuery, (err) => {
        if(err) throw err;

        console.log("Database Created Successfully !");

        let useQuery = `USE ${databaseName}`;
        database.query(useQuery, (error) => {
            if(error) throw error;

            console.log("Using Database");

            return res.send(
`Created and Using ${databaseName} Database`);
        })
    });
});

// Route pour l'inscription (register)
app.get('/register', (req, res) => {
  res.render('register'); // Utilisez res.render pour afficher la page EJS (assurez-vous que 'login.ejs' existe dans le dossier 'views')
});

app.get('/login', (req, res) => {
  res.render('login'); // Utilisez res.render pour afficher la page EJS (assurez-vous que 'login.ejs' existe dans le dossier 'views')
});
// Route pour l'inscription (register)
app.post('/register', (req, res) => {
  const { username, password } = req.body;

  // Sélectionnez la base de données
  database.query('USE gfg_db', (useErr) => {
    if (useErr) {
      console.error('Erreur lors de la sélection de la base de données : ' + useErr.message);
      res.status(500).json({ error: 'Erreur lors de la sélection de la base de données' });
    } else {
      // Insérez le nouvel utilisateur dans la base de données (vous devrez créer une table "users" dans votre base de données)
      database.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, password], (err, results) => {
        if (err) {
          console.error('Erreur lors de l\'inscription : ' + err.message);
          res.status(500).json({ error: 'Erreur lors de l\'inscription' });
        } else {
          console.log('Utilisateur inscrit avec succès !');
          res.redirect('/success');
        }
      });
    }
  });
});

// Route pour l'authentification (login)
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Sélectionnez la base de données
  database.query('USE gfg_db', (useErr) => {
    if (useErr) {
      console.error('Erreur lors de la sélection de la base de données : ' + useErr.message);
      res.status(500).json({ error: 'Erreur lors de la sélection de la base de données' });
    } else {
      // Vérifiez les informations d'identification dans la base de données
      database.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], (err, results) => {
        if (err) {
          console.error('Erreur lors de l\'authentification : ' + err.message);
          res.status(500).json({ error: 'Erreur lors de l\'authentification' });
        } else {
          if (results.length > 0) {
            console.log('Authentification réussie !');
            res.redirect('/success'); // Redirige vers une page de succès
          } else {
            console.log('Authentification échouée : nom d\'utilisateur ou mot de passe incorrect');
            res.status(401).json({ error: 'Nom d\'utilisateur ou mot de passe incorrect' });
          }
        }
      });
    }
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

  const GoogleStrategy = require('passport-google-oauth2').Strategy;
  const GOOGLE_CLIENT_ID = '444052914844-03578lm9fm3qvk5g9od06b089ebepgiq.apps.googleusercontent.com';
  const GOOGLE_CLIENT_SECRET = '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';
  passport.use(new GoogleStrategy({
      clientID: GOOGLE_CLIENT_ID,
      clientSecret: GOOGLE_CLIENT_SECRET,
      callbackURL: "http://localhost:3000/auth/google/callback"
    },
    function(accessToken, refreshToken, profile, done) {
        userProfile=profile;
        console.log(accessToken);
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
  console.log('Serveur démarré sur le port 3000');
});
