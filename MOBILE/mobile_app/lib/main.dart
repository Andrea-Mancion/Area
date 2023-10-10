// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/login_page.dart';
// import 'package:mobile_app/pages/login_page.dart';
void main() {
  /*Timer.periodic(Duration(seconds: 5), (Timer timer) {
    // Placez le code que vous souhaitez exécuter ici
    print('Cette ligne s\'exécutera toutes les 5 secondes.');
    });*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
