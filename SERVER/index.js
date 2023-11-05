const express = require('express');
const app = express();
const session = require('express-session');
require('dotenv').config();

app.set('view engine', 'ejs');

app.use(session({
  resave: false,
  saveUninitialized: true,
  secret: 'SECRET'
}));

app.get('/success', function(req, res) {
  res.render('pages/auth');
});

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
    callbackURL: "http://localhost:8080/auth/google/callback"
  },
  function(accessToken, refreshToken, profile, done) {
      userProfile=profile;
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

module.exports = app;