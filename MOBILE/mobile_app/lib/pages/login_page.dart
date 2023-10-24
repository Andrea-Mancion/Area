import 'package:flutter/material.dart';
import 'package:mobile_app/pages/create_task_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_app/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  void _login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://10.19.254.241:3000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        message = 'Logged in successfully';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateTaskPage()),
        );
      } else {
        setState(() {
          message = ('Mauvais identifiants ou mot de passe');
        });
      };
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 50),
              const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: _passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ),
                ),
              ),
              if (message.isNotEmpty)
                const SizedBox(
                  height: 20,
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Text(
                message,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
