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
      Uri.parse("http://${AllVariables.ipMan}:3000/about.json"),
       headers: {
      'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      final reponse = jsonDecode(response.body);
      for (var service in reponse['server']['services']) {
        String serviceName = service['name'];
        //get Actions
        for (var action in service['actions']) {
          String actionName = action['name'];
          String actionDescription = action['description'];
          List<dynamic>? actionParam = action['parametter'];
          switch (serviceName) {
            case 'deezer':
              deezer.allAction.add(ActionReaction(actionName, actionDescription, actionParam??[]));
              break;
            case 'discord':
              discord.allAction.add(ActionReaction(actionName, actionDescription, actionParam??[]));
              break;
            case 'github':
              github.allAction.add(ActionReaction(actionName, actionDescription, actionParam??[]));
              break;
            case 'spotify':
              spotify.allAction.add(ActionReaction(actionName, actionDescription, actionParam??[]));
              break;
            case 'twitch':
              twitch.allAction.add(ActionReaction(actionName, actionDescription, actionParam??[]));
              break;
            case 'yahoo':
              yahoo.allAction.add(ActionReaction(actionName, actionDescription, actionParam??[]));
              break;
            default:
              break;
          }
        }
        //get Reactions
        for (var reaction in service['reactions']) {
          String reactionName = reaction['name'];
          String reactionDescription = reaction['description'];
          List<dynamic>? reactionParam = reaction['parametter'];
          switch (serviceName) {
            case 'deezer':
              deezer.allReaction.add(ActionReaction(reactionName, reactionDescription, reactionParam??[]));
              break;
            case 'discord':
              discord.allReaction.add(ActionReaction(reactionName, reactionDescription, reactionParam??[]));
              break;
            case 'github':
              github.allReaction.add(ActionReaction(reactionName, reactionDescription, reactionParam??[]));
              break;
            case 'spotify':
              spotify.allReaction.add(ActionReaction(reactionName, reactionDescription, reactionParam??[]));
              break;
            case 'twitch':
              twitch.allReaction.add(ActionReaction(reactionName, reactionDescription, reactionParam??[]));
              break;
            case 'yahoo':
              yahoo.allReaction.add(ActionReaction(reactionName, reactionDescription, reactionParam??[]));
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
    // getAllAction();
    if (AllVariables.ipMan == "") {
      AllVariables.ipMan = "10.19.255.70";
    }
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
        title: const Text(""),
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
                      MaterialPageRoute(builder: (context) => const AllServicePage(isAction: true)),
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
                      MaterialPageRoute(builder: (context) => const AllServicePage(isAction: false)),
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
                print("action: ${AllVariables.action}");
                print("reaction: ${AllVariables.reaction}");
                print("actionDescription: ${AllVariables.actionDescription}");
                print("reactionDescription: ${AllVariables.reactionDescription}");
                print("actionPrint: ${AllVariables.actionPrint}");
                print("reactionPrint: ${AllVariables.reactionPrint}");
                print("nameServiceAction: ${AllVariables.nameServiceAction}");
                print("nameServiceReaction: ${AllVariables.nameServiceReaction}");
                print("controllersAction: ${AllVariables.controllersAction}");
                print("controllersReaction: ${AllVariables.controllersReaction}");
                print("accessToken: ${AllVariables.accessToken}");
                print("ipman = ${AllVariables.ipMan}");
                postDataToServer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                AllVariables.controllersAction.clear();
                AllVariables.controllersReaction.clear();
                AllVariables.action = "";
                AllVariables.actionPrint = "";
                AllVariables.reaction = "";
                AllVariables.reactionPrint = "";
              },
              child: const Text("Confirmer"),
            )
          ],
        ),
      ),
    );
  }
}