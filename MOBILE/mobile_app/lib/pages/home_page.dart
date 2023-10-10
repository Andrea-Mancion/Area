import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
const double _verticalSpacing = 20;
const double _horizontalSpacing = 30;
const double _buttonWidth = 130;
const double _buttonHeight = 130;
const Color _buttonColor = Color.fromRGBO(217, 217, 217, 1);
const String _buttonText = "Service";
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
        const Text("Home Page"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 30),
              SizedBox(
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_buttonColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    )
                  ),
                  onPressed: () => print(_buttonText),
                  child: const Text(_buttonText),
                ),
              ),
              const SizedBox(width: _horizontalSpacing),
              SizedBox(
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_buttonColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    )
                  ),
                  onPressed: () => print(_buttonText),
                  child: const Text(_buttonText),
                ),
              ),
            ],
          ),
          const SizedBox(height: _verticalSpacing),
          Row(
            children: [
              const SizedBox(width: 30),
              SizedBox(
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_buttonColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    )
                  ),
                  onPressed: () => print(_buttonText),
                  child: const Text(_buttonText),
                ),
              ),
              const SizedBox(width: _horizontalSpacing),
              SizedBox(
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_buttonColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    )
                  ),
                  onPressed: () => print(_buttonText),
                  child: const Text(_buttonText),
                ),
              ),
            ],
          ),
          const SizedBox(height: _verticalSpacing),
          Row(
            children: [
              const SizedBox(width: 30),
              SizedBox(
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_buttonColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    )
                  ),
                  onPressed: () => print(_buttonText),
                  child: const Text(_buttonText),
                ),
              ),
              const SizedBox(width: _horizontalSpacing),
              SizedBox(
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_buttonColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    )
                  ),
                  onPressed: () => print(_buttonText),
                  child: const Text(_buttonText),
                ),
              ),
            ],
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
              child: const Text("Create a Task"),
            ),
          )
        ],
      )
    );
  }
}