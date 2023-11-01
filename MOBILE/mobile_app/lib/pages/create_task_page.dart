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
      final reponse = jsonDecode(response.body);
      for (var service in reponse['server']['services']) {
        String serviceName = service['name'];
        // get Actions
        for (var action in service['actions']) {
          String actionName = action['name'];
          switch (serviceName) {
            case 'deezer':
              deezer.allAction.add(actionName);
              break;
            case 'discord':
              discord.allAction.add(actionName);
              break;
            case 'github':
              github.allAction.add(actionName);
              break;
            case 'google':
              google.allAction.add(actionName);
              break;
            case 'spotify':
              spotify.allAction.add(actionName);
              break;
            case 'twitch':
              twitch.allAction.add(actionName);
              break;
            case 'yahoo':
              yahoo.allAction.add(actionName);
              break;
            default:
              break;
          }
        }
        //get Reactions
        for (var reaction in service['reactions']) {
          String reactionName = reaction['name'];
          switch (serviceName) {
            case 'deezer':
              deezer.allReaction.add(reactionName);
              break;
            case 'discord':
              discord.allReaction.add(reactionName);
              break;
            case 'github':
              github.allReaction.add(reactionName);
              break;
            case 'google':
              google.allReaction.add(reactionName);
              break;
            case 'spotify':
              spotify.allReaction.add(reactionName);
              break;
            case 'twitch':
              twitch.allReaction.add(reactionName);
              break;
            case 'yahoo':
              yahoo.allReaction.add(reactionName);
              break;
            default:
              break;
          }
        }
        // get Action Description
        for (var action in service['actions']) {
          String actionDescription = action['description'];
          switch (serviceName) {
            case 'deezer':
              deezer.allActionDescription.add(actionDescription);
              break;
            case 'discord':
              discord.allActionDescription.add(actionDescription);
              break;
            case 'github':
              github.allActionDescription.add(actionDescription);
              break;
            case 'google':
              google.allActionDescription.add(actionDescription);
              break;
            case 'spotify':
              spotify.allActionDescription.add(actionDescription);
              break;
            case 'twitch':
              twitch.allActionDescription.add(actionDescription);
              break;
            case 'yahoo':
              yahoo.allActionDescription.add(actionDescription);
              break;
            default:
              break;
          }
        }
        // get Reaction Description
        for (var reaction in service['reactions']) {
          String reactionDescription = reaction['description'];
          switch (serviceName) {
            case 'deezer':
              deezer.allReactionDescription.add(reactionDescription);
              break;
            case 'discord':
              discord.allReactionDescription.add(reactionDescription);
              break;
            case 'github':
              github.allReactionDescription.add(reactionDescription);
              break;
            case 'google':
              google.allReactionDescription.add(reactionDescription);
              break;
            case 'spotify':
              spotify.allReactionDescription.add(reactionDescription);
              break;
            case 'twitch':
              twitch.allReactionDescription.add(reactionDescription);
              break;
            case 'yahoo':
              yahoo.allReactionDescription.add(reactionDescription);
              break;
            default:
              break;
          }
        }
      }
    } else {
      print('GET request failed with status: ${response.statusCode}');
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