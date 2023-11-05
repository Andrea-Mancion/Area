import 'package:mobile_app/variable.dart';
import 'package:mobile_app/github_oauth2.dart';
import 'package:mobile_app/spotify_oauth2.dart';
import 'package:mobile_app/discord_oauth2.dart';
import 'package:mobile_app/twitch_oauth2.dart';
import 'package:mobile_app/yahoo_oauth2.dart';

void performOAuth2(Service service, bool isAction) {
  switch (service.name) {
    case "Spotify":
      spotifyAuthentication();
      break;
    case "Deezer":
      print("deezer not implemented yet");
      break;
    case "Discord":
      discordAuthentication();
      break;
    case "Github":
      githubOAuth2Authentication();
      break;
    case "Twitch":
      twitchOAuth2();
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
