import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:mobile_app/variable.dart';

class CreatePlayListPage extends StatefulWidget {
  const CreatePlayListPage({super.key});

  @override
  State<CreatePlayListPage> createState() => _CreatePlayListPageState();
}
class _CreatePlayListPageState extends State<CreatePlayListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("create playlist"),
      ),
      body: Center(
        child:
          Column(
            children: [
              const SizedBox(height: 100),
              TextField(
                controller: AllVariables.spotifyCreatePlaylistReactionName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Playlist name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: AllVariables.spotifyPlaylistReactionDescription,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Playlist description',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: AllVariables.spotifyPlaylistReactionPrivate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Private (true or false)',
                ),
              ),
              const SizedBox(height: 200),
              ElevatedButton(
                onPressed: () {
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