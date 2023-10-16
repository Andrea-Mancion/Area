import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/pages/login_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  void _register() async {
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://10.19.255.75:3000/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        message = 'Registered successfully';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        setState(() {
          message = 'User is already registered';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e'; // Handle network errors
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const SizedBox(height: 80),
            Flexible(
              child: Image.asset("assets/images/logo.png",
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 80),
            const Text("Inscription",
                style:TextStyle(
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 10),
             SizedBox(
                width: 330,
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Entrer une adresse mail',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: 330,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Entrer un mot de passe',
                  suffixIcon: IconButton(
                      icon: _passwordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                obscureText: !_passwordVisible,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text("S'inscrire",
                style :TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 0, 0)
                )
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      )
    );
  }
}