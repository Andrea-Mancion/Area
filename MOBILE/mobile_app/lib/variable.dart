import 'package:flutter/material.dart';
class AllVariables {

  static String reaction = "";
  static String action = "";
  static String accessTokenSpotify = '';
  static String discordAccessToken = '';
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
  static const String spotifyAction5 = "Merci Aurélien et Antoine";
  static const String spotifyAction6 = "c'est l'anniv d'andrea";
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
  static String imageDeezer = "assets/images/Logo_Deezer.png";
  static String imageDiscord = "assets/images/Logo_Discord.png";
  static String imageGithub = "assets/images/Logo_Github.png";
  static String imageGoogle = "assets/images/Logo_Google.png";
  static String imageSpotify = "assets/images/Logo_Spotify.png";
  static String imageTwitch = "assets/images/Logo_Twitch.png";
  static String imageYahoo = "assets/images/Logo_Yahoo.png";
}
Service spotify = Service(AllVariables.imageSpotify);
Service deezer = Service(AllVariables.imageDeezer);
Service discord = Service(AllVariables.imageDiscord);
Service github = Service(AllVariables.imageGithub);
Service google = Service(AllVariables.imageGoogle);
Service twitch = Service(AllVariables.imageTwitch);
Service yahoo = Service(AllVariables.imageYahoo);
class Service {
  Service(
    this.image,
  );
  String image = '';
  List<String> allAction = [];
  List<String> allReaction = [];
  List<String> allActionDescription = [];
  List<String> allReactionDescription = [];
  List<String> actionParameters = [];
  List<String> reactionParameters = [];
}
