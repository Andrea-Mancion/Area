import 'package:flutter/material.dart';
import 'package:mobile_app/pages/action_page.dart';
import 'package:mobile_app/pages/reaction_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            SizedBox(
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
                    MaterialPageRoute(builder: (context) => const ActionPage()),
                  );
                },
                child: const Text("Create an Action",
                  style :TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255)
                  )
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
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
                    MaterialPageRoute(builder: (context) => const ReactionPage()),
                  );
                },
                child: const Text("Create a Reaction",
                  style :TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255)
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}