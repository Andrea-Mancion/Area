import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/login_page.dart';

const double verticaleSpace = 60;
const double horizontalSpace = 20;

class ReactionPage extends StatefulWidget {
  const ReactionPage({super.key});

  @override
  State<ReactionPage> createState() => ReaActionPageState();
}

class ReaActionPageState extends State<ReactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 120),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      child: const Text("Service 1"),
                    ),
                  ),
                  const SizedBox(width: horizontalSpace),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text("login Page"),
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: verticaleSpace),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      child: const Text("Home Page"),
                    ),
                  ),
                  const SizedBox(width: horizontalSpace),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text("login Page"),
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: verticaleSpace),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      child: const Text("Home Page"),
                    ),
                  ),
                  const SizedBox(width: horizontalSpace),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                        backgroundColor:MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text("login Page"),
                    ),
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  }
}