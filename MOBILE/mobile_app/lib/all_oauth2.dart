import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:mobile_app/github_oauth2.dart';
import 'package:mobile_app/spotify_oauth2.dart';
import 'package:mobile_app/discord_oauth2.dart';
import 'package:mobile_app/twitch_oauth2.dart';
import 'package:mobile_app/yahoo_oauth2.dart';
import 'package:mobile_app/variable.dart';
import 'package:mobile_app/pages/service_page.dart';

Future<void> performOAuth2(Service service, bool isAction) {
  switch (service.name) {
    case "Spotify":
      spotifyAuthentication();
      ServicePage(isAction: isAction, service: spotify);
      break;
    case "Deezer":
      print("deezer not implemented yet");
      break;
    case "Discord":
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DiscordAuthenticationPage()),
      );
      ServicePage(isAction: isAction, service: discord);
      break;
    case "Github":
      githubOAuth2Authentication();
      ServicePage(isAction: isAction, service: github);
      break;
    case "Twitch":
      twitchOAuth2();
      ServicePage(isAction: isAction, service: twitch);
      break;
    case "Yahoo":
      yahooAuthentication();
      print("yahoo not implemented yet");
      break;
    default:
      print("service unknown");
      break;
  }
}

