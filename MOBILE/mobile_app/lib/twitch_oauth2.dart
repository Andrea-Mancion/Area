import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';

Future<void> twitchOAuth2() async {
  final twitchClientId = 'wvtkdzlzxnrm3yucfl9tgx7sh2oqw5';
  final redirectUri = 'mobile:/';

  if (AllVariables.accessToken["Twitch"] != '') {
    return;
  }
  final url = Uri.https('id.twitch.tv', '/oauth2/authorize', {
    'response_type': 'code',
    'client_id': twitchClientId,
    'redirect_uri': redirectUri,
    'scope': 'user:read:email user:read:follows moderator:read:followers',
  });

  try {
    final result = await FlutterWebAuth.authenticate(
      url: url.toString(),
      callbackUrlScheme: 'mobile',
    );

    final code = Uri.parse(result).queryParameters['code'];

    final Uri tokenUri = Uri.parse('https://id.twitch.tv/oauth2/token');
    final response = await http.post(
      tokenUri,
      body: {
        'client_id': twitchClientId,
        'client_secret': 'udyhldr69xvap2ur0z85xtj3j59ndu',
        'redirect_uri': redirectUri,
        'grant_type': 'authorization_code',
        'code': code,
      },
      headers: {"content-type": "application/x-www-form-urlencoded"},
    );

    AllVariables.accessToken["Twitch"] = jsonDecode(response.body)['access_token'] as String;
    print("Twitch access token: ${AllVariables.accessToken["Twitch"]}");
  } catch (e) {
    print('Error: $e');
  }
}
