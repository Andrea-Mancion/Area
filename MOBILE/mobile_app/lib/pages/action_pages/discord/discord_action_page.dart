import 'package:flutter/material.dart';
import 'package:mobile_app/variable.dart';

class DiscordActionPage extends StatefulWidget {
  const DiscordActionPage({super.key});

  @override
  State<DiscordActionPage> createState() => _DiscordActionPageState();
}

const double spaceBetweenButton = 30;
const double heightButton = 45;
const double widthButton = 220;

class _DiscordActionPageState extends State<DiscordActionPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("Discord Action Page"),
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
                                        'assets/images/discord.png',
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
                                        MaterialPageRoute(builder: (context) => const DiscordActionPage()),
                                    );
                                    AllVariables.Action = "send_weather_hour";
                                    AllVariables.actionPrint = "Send the weather of the day";
                                },
                                child: const Text(AllVariables.discordAction1)
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
                                        MaterialPageRoute(builder: (context) => const DiscordActionPage()),
                                    );
                                    AllVariables.Action = "send_weather_diff";
                                    AllVariables.actionPrint = "Send the new weather when there is a difference";
                                },
                                child: const Text(AllVariables.discordAction2)
                            ),
                        ),
                        const SizedBox(height: spaceBetweenButton),
                        const SizedBox(height: spaceBetweenButton),
                    ],
                )
            )
        );
    }
}