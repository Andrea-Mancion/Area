import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/pages/reaction_pages/spotify_reaction_page.dart';

const double verticaleSpace = 60;
const double horizontalSpace = 20;

class ThenThatPage extends StatefulWidget {
  const ThenThatPage({super.key});

  @override
  State<ThenThatPage> createState() => ThenThatPageState();
}

class ThenThatPageState extends State<ThenThatPage> {
  final caseColor = const Color.fromRGBO(217, 217, 217, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Then That Page"),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SpotifyReactionPage()),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreateTaskPage()),
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