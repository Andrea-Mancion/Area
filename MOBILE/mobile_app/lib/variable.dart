import 'package:flutter/material.dart';
class AllVariables {

  static String reaction = "";
  static String action = "";
  static String accessTokenSpotify = '';
  static String discordAccessToken = '';
  static String twitchAccessToken = '';
  static String deezerAccessToken = '';
  static String accessTokenYahoo = '';
  static String accessTokenGoogle = '';
  static var actionDescription = <String, dynamic>{

  };
  static var reactionDescription = <String, dynamic>{


  };
  static String reactionPrint = "";
  static String actionPrint = "";
  static const double spaceBetweenButton = 30;
  static const double heightButton = 45;
  static const double widthButton = 220;
  static const String spotifyAction1 = "Nouvelle musique enregistrée";
  static const String spotifyAction2 = "Nouvel episode de podcast suivi";
  static const String spotifyAction3 = "test";
  static const String spotifyAction4 = "test";
  static const String spotifyReaction1 = "Add Items To Playlist";
  static const String spotifyReaction2 = "Créer une playlist";
  static const String discordAction1 = "météo_heure";
  static const String discordAction2 = "La météo change";
  static final TextEditingController spotifyCreatePlaylistReactionName = TextEditingController();
  static final TextEditingController spotifyCreatePlaylistReactionDescription = TextEditingController();
  static final TextEditingController spotifyCreatePlaylistReactionPrivate = TextEditingController();
  static final TextEditingController spotifyAddItemToPlaylistReactionName = TextEditingController();
  static List<String> tasks = [createTask];
  static int taskIndex = 0;
  static List<String> getTask() {
    return tasks;
  }
  static int nbTask = 1;
  static String createNewTask = "Créer une nouvelle tâche";
  static String createTask = "Créer une tâche";
}
