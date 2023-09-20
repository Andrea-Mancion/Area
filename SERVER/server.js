const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const database = require('./sqlConnection');

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
    res.send('Connexion réussie !');
});

// Démarrer le serveur sur le port 3000
app.listen(port, () => {
  console.log('Serveur démarré sur le port 3000');
});
