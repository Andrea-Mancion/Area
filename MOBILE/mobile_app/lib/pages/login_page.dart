import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const SizedBox(height: 80),
            Flexible(
              flex: 3,
              child: Image.asset("assets/images/logo.png",
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              )
            ),
            const SizedBox(height: 80),
            const Flexible(
              child: Text("Log in",
                style:TextStyle(
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Flexible(
              flex: 1,
              child: SizedBox(
                width: 330,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: SizedBox(
                width: 330,
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: Flexible(
                      child: IconButton(
                        icon: _passwordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    )
                  ),
                  obscureText: !_passwordVisible,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text("Connexion",
                  style :TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 0, 0)
                  )
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Image.asset("assets/images/google.png",
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                     const Text("Continue with Google",
                      style :TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0)
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
