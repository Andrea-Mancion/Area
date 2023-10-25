import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/variable.dart';

class SendWeatherHourPage extends StatefulWidget {
  const SendWeatherHourPage({super.key});

  @override
  State<SendWeatherHourPage> createState() => _SendWeatherHourPageState();
}

class _SendWeatherHourPageState extends State<SendWeatherHourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Météo_heure Hour Page"),
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
