import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/if_this_page.dart';
import 'package:mobile_app/pages/then_that_page.dart';
import 'package:mobile_app/variable.dart';
import 'package:mobile_app/send_information_to_server.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  String whatPrintIf = "";
  String whatPrintThen = "";
  @override
  Widget build(BuildContext context) {
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
                      MaterialPageRoute(builder: (context) => const IfThisPage()),
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
                      MaterialPageRoute(builder: (context) => const ThenThatPage()),
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