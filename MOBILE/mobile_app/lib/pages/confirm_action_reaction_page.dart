import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/variable.dart';

class ConfimActionReactionPage extends StatefulWidget {
  final ActionReaction trigger;
  final Service service;
  final bool isAction;
  const ConfimActionReactionPage(
    this.trigger,
    this.service,
    this.isAction,
    {super.key}
  );

  @override
  State<ConfimActionReactionPage> createState() => _ConfimActionReactionPageState();
}

class _ConfimActionReactionPageState extends State<ConfimActionReactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Action Reaction"),
      ),
      body:
       ConfirmFeildParamActionReaction(widget.trigger, widget.service, widget.isAction, key: UniqueKey()),
    );
  }
}

class ConfirmFeildParamActionReaction extends StatelessWidget {
  final ActionReaction trigger;
  final Service service;
  final bool isAction;
  ConfirmFeildParamActionReaction(
    this.trigger,
    this.service,
    this.isAction,
    {super.key}
  );
  final List<TextEditingController> params = [];
    bool checkEmptyfeild(context) {
      for (var i = 0; i < trigger.parameters.length; i++) {
        if (params[i].text == "") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Mauvais Paramètre"),
              content: Text("Le paramètre ${trigger.parameters[i]} est vide"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ]
            )
          );
          return false;
        }
      }
      return true;
    }
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < trigger.parameters.length; i++) {
      params.add(TextEditingController());
    }
    print("is action : $isAction");
    return Column(
      children: [
        Expanded(
          child: (
            CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return SizedBox(
                        width: 50,
                        child: TextField(
                          controller: params[index],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: trigger.parameters[index],
                          ),
                        ),
                      );
                    },
                    childCount: trigger.parameters.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4,
                  ),
                ),
              ],
            )
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (isAction) {
              if (!checkEmptyfeild(context)) {
                return;
              }
              for (var i = 0; i < trigger.parameters.length; i++) {
                AllVariables.controllersAction.add(params[i].text);
              }
              AllVariables.action = trigger.name;
              AllVariables.actionPrint = trigger.description;
              params.clear();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateTaskPage()),
              );
            } else {
              if (!checkEmptyfeild(context)) {
                return;
              }
              for (var i = 0; i < trigger.parameters.length; i++) {
                AllVariables.controllersReaction.add(params[i].text);
              }
              params.clear();
              AllVariables.reaction = trigger.name;
              AllVariables.reactionPrint = trigger.description;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateTaskPage()),
              );
            }
          },
          child: const Text("Confirmer"),
        )
      ],
    );
  }
}
