import 'package:flutter/material.dart';
import 'package:mobile_app/variable.dart';

class ConfimActionReactionPage extends StatefulWidget {
  final ActionReaction trigger;
  const ConfimActionReactionPage(
    this.trigger,
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
       ConfirmFeildParamActionReaction(widget.trigger, key: UniqueKey()),
    );
  }
}

class ConfirmFeildParamActionReaction extends StatelessWidget {
  final ActionReaction trigger;
  const ConfirmFeildParamActionReaction(
    this.trigger,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: (
            CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return TextFeildParam(trigger.parameters[index]);
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
      ],
    );
  }
}

class TextFeildParam extends StatelessWidget {
  final String text;
  const TextFeildParam(
    this.text,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: text,
        ),
      ),
    );
  }
}