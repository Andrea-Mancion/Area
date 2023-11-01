import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/all_service_page.dart';
// import 'package:mobile_app/pages/then_that_page.dart';
import 'package:mobile_app/variable.dart';
import 'package:mobile_app/send_information_to_server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  String whatPrintIf = "";
  String whatPrintThen = "";

  void getAllAction() async{
    final response = await http.get(
      Uri.parse("http://10.19.255.70:3000/about.json"),
       headers: {
      'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      print('GET request successful');
    } else {
      print('GET request failed with status: ${response.statusCode}');
    }
    final reponse = jsonDecode(response.body);
    print("---aee =  ${reponse.toString()}---");

    for (var service in reponse['server']['services']) {
      String serviceName = service['name'];
      for (var action in service['actions']) {
        String actionName = action['name'];
        switch (serviceName) {
          case 'deezer':
            AllVariables.deezerAction.add(actionName);
            break;
          case 'discord':
            AllVariables.discordAction.add(actionName);
            break;
          case 'github':
            AllVariables.githubAction.add(actionName);
            break;
          case 'google':
            AllVariables.googleAction.add(actionName);
            break;
          case 'spotify':
            AllVariables.spotifyAction.add(actionName);
            break;
          case 'twitch':
            AllVariables.twitchAction.add(actionName);
            break;
          case 'yahoo':
            AllVariables.yahooAction.add(actionName);
            break;
          default:
            break;
        }
        if (serviceName == 'deezer') {
        } else if (serviceName == 'discord') {
          AllVariables.discordAction.add(actionName);
        }
      }
      for (var reaction in service['reactions']) {
        String reactionName = reaction['name'];
        switch (serviceName) {
          case 'deezer':
            AllVariables.deezerReaction.add(reactionName);
            break;
          case 'discord':
            AllVariables.discordReaction.add(reactionName);
            break;
          case 'github':
            AllVariables.githubReaction.add(reactionName);
            break;
          case 'google':
            AllVariables.googleReaction.add(reactionName);
            break;
          case 'spotify':
            AllVariables.spotifyReaction.add(reactionName);
            break;
          case 'twitch':
            AllVariables.twitchReaction.add(reactionName);
            break;
          case 'yahoo':
            AllVariables.yahooReaction.add(reactionName);
            break;
          default:
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllAction();
    if (AllVariables.action == "") {
      whatPrintIf = "...";
    } else {
      whatPrintIf = AllVariables.actionPrint;
    }
    if (AllVariables.reaction == "") {
      whatPrintThen = "...";
    } else {
      whatPrintThen = AllVariables.reactionPrint;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crée une tâche"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Flexible(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllServicePage(isAction: true)),
                    );
                  },
                  child: Text("Si \"$whatPrintIf\"",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255)
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Flexible(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllServicePage(isAction: false)),
                    );
                  },
                  child: Text("Fais \"$whatPrintThen\"",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255)
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                AllVariables.tasks[AllVariables.taskIndex] = ("Si \"${AllVariables.actionPrint}\", fais \"${AllVariables.reactionPrint}\"");
                AllVariables.tasks.add(AllVariables.createNewTask);
                AllVariables.nbTask++;
                AllVariables.taskIndex++;
                postDataToServer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text("Confirmer"),
            )
          ],
        ),
      ),
    );
  }
}