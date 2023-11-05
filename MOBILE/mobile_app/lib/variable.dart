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
  static var controllersAction = <String, dynamic>{};
  static var controllersReaction = <String, dynamic>{};
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
  static List<ActionReaction> spotifyAction = [
    ActionReaction("check_new_saved_track", "Une nouvelle musique est enregistrée", []),
    ActionReaction("check_new_episode", "Un nouvel episode d'un podcast donné est mis en ligne", ["show_id"]),
  ];
  static List<ActionReaction> spotifyReaction = [
    ActionReaction("create_playlist", "Créer une playliste", ["name", "description", "private"]),
    ActionReaction("add_item_to_playlist", "Ajoute une musique a une playliste", ["name"]),
    ActionReaction("add_track_to_queue", "Ajoute une musique donnée dans la queue (premium only)", ["track_id"]),
    ActionReaction("set_volume", "Met le volume à une valeur donnée (premium only)", ["volume"]),
    ActionReaction("start_song", "Recommence la musique en cours (premium only)", []),
    ActionReaction("pause_song", "Pause la musique en cours (premium only)", []),
    ActionReaction("next_song", "Joue la prochiane musique dans la queue (premium only)", []),
    ActionReaction("previous_song", "Joue l'ancienne musique dans la queue (premium only)", []),
    ActionReaction("follow_playlist", "Suis la prochaine playliste", ["playlist_id"]),
    ActionReaction("unfollow_playlist", "Ne suis plus la prochiane playliste", ["playlist_id"]),
    ActionReaction("remove_saved_track", "Suprimme la musique donnée", ["id de la musique"]),
    ActionReaction("save_show", "Sauvegarde le podcast donné", ["id du podcast"]),
    ActionReaction("remove_saved_show", "Enlève le podcast suivi donnée", ["id du podcast"]),
  ];
  static List<ActionReaction> discordAction = [
    ActionReaction("weather_hour", "Get the weather at a certain hour", ["hour"]),
    ActionReaction("weather_diff", "Get the weather difference when there is a big difference", []),
  ];
  static List<ActionReaction> discordReaction = [
    ActionReaction("list_message","list all the message in a channel",[]),
    ActionReaction("send_message","send a message in a channel",["message"]),
    ActionReaction("send_weather", "send the weather in a channel", []),
    ActionReaction("send_mail", "send a message by mail", ["message"])
  ];
  static List<ActionReaction> githubAction = [
    ActionReaction("check_new_issues", "check if we have a new issue", []),
  ];
  static List<ActionReaction> githubReaction = [
  ];
  static List<ActionReaction> twitchAction = [
    ActionReaction("check_new_follow", "Check if we follow a new channel", []),
    ActionReaction("check_new_followers", "Check if we have a new follower", []),
    ActionReaction("get_schedule", "Get le calendrier d'un streamer", []),
    ActionReaction("get_video", "Get if il y a une nouvelle video", []),
    ActionReaction("get_stream", "Check si on est en stream ou non", [])
  ];
  static List<ActionReaction> twitchReaction = [
    ActionReaction("send_mail", "send a mail to a specific mail address", ["message"]),
  ];
  static List<ActionReaction> yahooAction = [
  ];
  static List<ActionReaction> yahooReaction = [
  ];
}
Service spotify = Service(AllVariables.imageSpotify, "Spotify", AllVariables.spotifyAction, AllVariables.spotifyReaction);
Service deezer = Service(AllVariables.imageDeezer, "Deezer", AllVariables.spotifyAction, AllVariables.spotifyReaction);
Service discord = Service(AllVariables.imageDiscord, "Discord", AllVariables.discordAction, AllVariables.discordReaction);
Service github = Service(AllVariables.imageGithub, "Github", AllVariables.githubAction, AllVariables.githubReaction);
Service twitch = Service(AllVariables.imageTwitch, "Twitch", AllVariables.twitchAction, AllVariables.twitchReaction);
Service yahoo = Service(AllVariables.imageYahoo, "Yahoo", AllVariables.spotifyAction, AllVariables.spotifyReaction);

class Service {
  Service(
    this.image,
    this.name,
    this.allAction,
    this.allReaction,
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