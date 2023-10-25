// import 'package:flutter/material.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:mobile_app/variable.dart';

Future<void> postDataToServer() async {
  //final String url = 'http://localhost:3000/create_action';

  /*final Map<String, dynamic> data = {
    'service_Name': 'Spotify',
    'action_Name': AllVariables.Action,
    'reaction_Name': AllVariables.Reaction,
    'action_Param': AllVariables.actionDescription,
    'reaction_Param': AllVariables.reactionDescription,
    'access_token': AllVariables.accessTokenSpotify,
    'user_id': '1234567',
  };*/

  final response = await http.post(
    Uri.parse("http://10.19.255.75:3000/create_action"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'service_Name': 'Spotify',
      'action_Name': AllVariables.action,
      'reaction_Name': AllVariables.reaction,
      'action_Param': AllVariables.actionDescription,
      'reaction_Param': AllVariables.reactionDescription,
      'access_token': AllVariables.accessTokenSpotify,
      'user_id': '1234567',
    }),
  );

  if (response.statusCode == 200) {
    print('POST request successful');
  } else {
    print('POST request failed with status: ${response.statusCode}');
  }
}