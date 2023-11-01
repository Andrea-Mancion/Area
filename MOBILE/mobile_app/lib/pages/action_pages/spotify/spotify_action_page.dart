import 'package:flutter/material.dart';
import 'package:mobile_app/pages/action_pages/spotify/new_save_track_page.dart';
import 'package:mobile_app/variable.dart';

class SpotifyActionPage extends StatefulWidget {
  const SpotifyActionPage({super.key});

  @override
  State<SpotifyActionPage> createState() => _SpotifyActionPageState();
}

const double spaceBetweenButton = 30;
const double heightButton = 45;
const double widthButton = 220;
class _SpotifyActionPageState extends State<SpotifyActionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spotify Action Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: 350,
                height: 250,
                color: const Color.fromRGBO(30, 215, 96, 1),
                child: Center(
                  child: Image.asset(
                    AllVariables.imageSpotify,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: widthButton,
              height: heightButton,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewSaveTrackActionSpotify()),
                  );
                  AllVariables.action = "check_new_saved_track";
                  AllVariables.actionPrint = "il y a une nouvelle musique enregistrée";
                },
                child: const Text(AllVariables.spotifyAction1)
              ),
            ),
            const SizedBox(height: spaceBetweenButton),
            SizedBox(
              width: widthButton,
              height: heightButton,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SpotifyActionPage()),
                  );
                  AllVariables.action = "check_new_episode";
                  AllVariables.actionPrint = "il y a un nouvel épisode";
                },
                child: const Text(AllVariables.spotifyAction2),
              ),
            ),
            const SizedBox(height: spaceBetweenButton),
            // SizedBox(
            //   width: widthButton,
            //   height: heightButton,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(5),
            //         )
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const SpotifyActionPage()),
            //       );
            //       action = spotifyAction3;
            //     },
            //     child: const Text(spotifyAction3)
            //   ),
            // ),
            const SizedBox(height: spaceBetweenButton),
            // SizedBox(
            //   width: widthButton,
            //   height: heightButton,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(5),
            //         )
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const SpotifyActionPage()),
            //       );
            //       action = spotifyAction4;
            //     },
            //     child: const Text(spotifyAction4)
            //   ),
            // )
          ],
        ),
      )
    );
  }
}
