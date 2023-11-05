import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';

Future<void> postDataToServer() async {
  final res = await http.post(
    Uri.parse("http://10.19.255.70:3000/create_action"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8'
    },
      body: jsonEncode(<String, dynamic>{
      'action_service_Name': AllVariables.nameServiceAction,
      'reaction_service_Name': AllVariables.nameServiceReaction,
      'action_Name': AllVariables.action,
      'reaction_Name': AllVariables.reaction,
      'action_Param': AllVariables.controllersAction,
      'reaction_Param': AllVariables.controllersReaction,
      'action_access_token': AllVariables.accessToken[AllVariables.nameServiceAction],
      'reaction_access_token': AllVariables.accessToken[AllVariables.nameServiceReaction],
      'user_id': 'Salut je suis l\'user is totalement useless',
      }),
  );
  if (res.statusCode == 200) {
    print('POST request successful');
  } else {
    print('POST request failed with status: ${res.statusCode}');
  }
}