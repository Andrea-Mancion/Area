import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/variable.dart';

class SendWeatherDiffPage extends StatefulWidget {
  const SendWeatherDiffPage({super.key});

  @override
  State<SendWeatherDiffPage> createState() => _SendWeatherDiffPageState();
}

class _SendWeatherDiffPageState extends State<SendWeatherDiffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Weather Hour Page"),
      ),
      body:Center(
        child: Column(
          children: [
            const SizedBox(height: 300),
             ElevatedButton(
                onPressed: () {
                  AllVariables.actionDescription = {
                    "": "",
                  };
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CreateTaskPage()));
                },
                child: const Text("confirm"),
              ),
          ],
        )
      ),
    );
  }
}
