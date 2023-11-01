import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/variable.dart';

class NewSaveTrackActionSpotify extends StatefulWidget {
  const NewSaveTrackActionSpotify({super.key});

  @override
  State<NewSaveTrackActionSpotify> createState() => _NewSaveTrackActionSpotifyState();
}

class _NewSaveTrackActionSpotifyState extends State<NewSaveTrackActionSpotify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Save Track"),
      ),
      body: Center(
        child:
          Column(
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
          ),
      ),
      backgroundColor: const Color.fromRGBO(30, 215, 96, 1),
    );
  }
}