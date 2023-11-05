import 'package:flutter/material.dart';
class AllVariables {

  static String reaction = "";
  static String action = "";
  static var actionDescription = <String, dynamic>{

  };
  static var reactionDescription = <String, dynamic>{


  };
  static String reactionPrint = "";
  static String actionPrint = "";
  static const double spaceBetweenButton = 30;
  static const double heightButton = 45;
  static const double widthButton = 220;
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
  static List<String> controllersAction = [];
  static List<String> controllersReaction = [];
  static String nameServiceAction = "";
  static String nameServiceReaction = "";
  static Map<String,String> accessToken = {
    "Spotify": "",
    "Deezer": "",
    "Discord": "",
    "Github": "",
    "Twitch": "",
    "Yahoo": "",
  };
}
Service spotify = Service(AllVariables.imageSpotify, "Spotify");
Service deezer = Service(AllVariables.imageDeezer, "Deezer");
Service discord = Service(AllVariables.imageDiscord, "Discord");
Service github = Service(AllVariables.imageGithub, "Github");
Service google = Service(AllVariables.imageGoogle, "Google");
Service twitch = Service(AllVariables.imageTwitch, "Twitch");
Service yahoo = Service(AllVariables.imageYahoo, "Yahoo");

class Service {
  Service(
    this.image,
    this.name,
  );
  String image = '';
  List<ActionReaction> allAction = [];
  List<ActionReaction> allReaction = [];
  List<String> tmp = [];
  String name = '';
  String accessToken = '';
}

class ActionReaction {
  ActionReaction(
    this.name,
    this.description,
    this.parameters,
  );
  int nbParam(int index) {
    return parameters.length;
  }
  String name = '';
  String description = '';
  List<dynamic> parameters = [];
}