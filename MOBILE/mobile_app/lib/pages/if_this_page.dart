import 'package:flutter/material.dart';
// import 'package:mobile_app/pages/home_page.dart';
// import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/service_page.dart';
import 'package:mobile_app/pages/action_pages/spotify/spotify_action_page.dart';
import 'package:mobile_app/spotify_oauth2.dart';
import 'package:mobile_app/discord_oauth2.dart';

const double verticaleSpace = 60;
const double horizontalSpace = 20;

class IfThisPage extends StatefulWidget {
  const IfThisPage({super.key});

  @override
  State<IfThisPage> createState() => IfThisPageState();
}

class IfThisPageState extends State<IfThisPage> {
  final caseColor = const Color.fromRGBO(217, 217, 217, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("If This Page"),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 80),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(caseColor),
                      ),
                      onPressed: () {
                        function();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SpotifyActionPage()),
                        );
                      },
                      child: Image.asset(
                        'assets/images/spotify.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  const SizedBox(width: horizontalSpace),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(caseColor),
                      ),
                        onPressed: () {
                          //discordAuthentication();
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DiscordAuthenticationPage()),
                        );
                      },
                      child: Image.asset(
                        'assets/images/discord.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: verticaleSpace),
            // SizedBox(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         width: 150,
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(0),
            //               )
            //             ),
            //             padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
            //             backgroundColor:MaterialStateProperty.all<Color>(caseColor),
            //           ),
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => const HomePage()),
            //             );
            //           },
            //           child: const Text("Home Page"),
            //         ),
            //       ),
            //       const SizedBox(width: horizontalSpace),
            //       SizedBox(
            //         width: 150,
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(0),
            //               )
            //             ),
            //             padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
            //             backgroundColor:MaterialStateProperty.all<Color>(caseColor),
            //           ),
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => const HomePage()),
            //             );
            //           },
            //           child: const Text("login Page"),
            //         ),
            //       ),
            //     ],
            //   )
            // ),
            // const SizedBox(height: verticaleSpace),
            // SizedBox(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         width: 150,
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(0),
            //               )
            //             ),
            //             padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
            //             backgroundColor:MaterialStateProperty.all<Color>(caseColor),
            //           ),
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => const HomePage()),
            //             );
            //           },
            //           child: const Text("Home Page"),
            //         ),
            //       ),
            //       const SizedBox(width: horizontalSpace),
            //       SizedBox(
            //         width: 150,
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(0),
            //               )
            //             ),
            //             padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
            //             backgroundColor:MaterialStateProperty.all<Color>(caseColor),
            //           ),
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => const HomePage()),
            //             );
            //           },
            //           child: const Text("login Page"),
            //         ),
            //       ),
            //     ],
            //   )
            // ),
          ]
        ),
      ),
    );
  }
}