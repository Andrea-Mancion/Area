import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/variable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
const Color _buttonColor = Color.fromRGBO(217, 217, 217, 1);
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void suppButton(index) {
      setState(() {
        AllVariables.tasks.removeAt(index);
        AllVariables.nbTask--;
        Navigator.pop(context);
        AllVariables.taskIndex--;
      });
    }
    return Scaffold(
      appBar: AppBar(title:
        const Text("Home Page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(_buttonColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)
                            )
                          )
                        ),
                        onPressed: () => {
                          if (AllVariables.tasks[index] == AllVariables.createNewTask || AllVariables.tasks[index] == AllVariables.createTask) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CreateTaskPage()),
                            )
                          }
                        },
                        onLongPress: () {
                          if (index == AllVariables.nbTask - 1) {
                            return;
                          }
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Supprimer cette tâche ?"),
                              content: Text("Etes-vous sur de vouloir supprimer cette tâche ?\n\n${AllVariables.tasks[index]}"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    suppButton(index);
                                  },
                                  child: const Text("OK"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ]
                            )
                          );
                        },
                        child: Text(AllVariables.tasks[index].toString()),
                      );
                    },
                    childCount: AllVariables.nbTask,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: 200,
            height: 30,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(117, 189, 255, 1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateTaskPage()),
                );
              },
              child: Text(AllVariables.createTask),
            ),
          ),
          const SizedBox(height: 80),
        ],
      )
    );
  }
}
