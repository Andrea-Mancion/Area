import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';

void yahooAuthentication() async {
  final yahooClientId = 'dj0yJmk9eUhobGhkcEJNbUVCJmQ9WVdrOVJqVjBiRUpZWkRBbWNHbzlNQT09JnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PThl';
  final yahooClientSecret = '9b3d0f6d9a464a8cb0a67be545895f73c46135be';
  final callbackUrlScheme = 'mobile';

  final url = Uri.https('api.login.yahoo.com', '/oauth2/request_auth', {
    'response_type': 'code',
    'client_id': yahooClientId,
    'redirect_uri': 'mobile:/',
    'scope': 'openid profile email',
  });

  try {
    final result = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: callbackUrlScheme);

    final code = Uri.parse(result).queryParameters['code'];

    final tokenUri = Uri.https('api.login.yahoo.com', '/oauth2/get_token');
    final response = await http.post(
      tokenUri,
      body: {
        'client_id': yahooClientId,
        'client_secret': yahooClientSecret,
        'redirect_uri': 'mobile:/',
        'code': code,
        'grant_type': 'authorization_code',
      },
      headers: {"content-type": "application/x-www-form-urlencoded"},
    );

    AllVariables.accessTokenYahoo = jsonDecode(response.body)['access_token'] as String;
    print("access token:");
    print(AllVariables.accessTokenYahoo);
  } catch (e) {
    print('Error: $e');
  }
}
