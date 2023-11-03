import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';

void githubOAuth2Authentication() async {
  final githubClientId = 'Iv1.040141ab174ea3f1';
  final githubClientSecret = '6c9db17717be8962cd41c3695f7b0a50ec4d9545';
  final callbackUrlScheme = 'mobile';

  final url = Uri.https('github.com', '/login/oauth/authorize', {
    'client_id': githubClientId,
    'redirect_uri': 'mobile://oauth2-callback',
    'scope': 'user',
    'response_type': 'code',
  });
  print(url);

  try {
    final result = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: callbackUrlScheme);

    final code = Uri.parse(result).queryParameters['code'];

    final tokenUri = Uri.https('github.com', '/login/oauth/access_token');
    final response = await http.post(
      tokenUri,
      body: {
        'client_id': githubClientId,
        'client_secret': githubClientSecret,
        'code': code,
      },
      headers: {"Accept": "application/json"},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('access_token')) {
      final accessToken = data['access_token'] as String;
      print("Access token: $accessToken");

      // Now you can use the GitHub access token for API requests.
    } else {
      print("Error: Failed to obtain access token");
    }
  } catch (e) {
    print('Error: $e');
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final clientId = '416261';
  final clientSecret = 'Iv1.040141ab174ea3f1';
  final redirectUri = 'mobile://oauth2-callback';
  final scopes = 'user';
  final state = 'your_state_value';

  Future<void> _authenticateWithGitHub() async {
    final authUrl = Uri.https(
      'github.com',
      '/login/oauth/authorize',
      {
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'scope': scopes,
        'state': state,
      },
    );

    try {
      final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: 'mobile',
      );

      final code = Uri.parse(result).queryParameters['code'];

      if (code != null) {
        final tokenUrl = Uri.https(
          'github.com',
          '/login/oauth/access_token',
          {
            'client_id': clientId,
            'client_secret': clientSecret,
            'code': code,
            'redirect_uri': redirectUri,
          },
        );

        final tokenResponse = await http.post(tokenUrl);

        if (tokenResponse.statusCode == 200) {
          final Map<String, dynamic> data = Uri.splitQueryString(tokenResponse.body);
          final accessToken = data['access_token'];
          print('Access Token: $accessToken');

          if (accessToken != null) {
            final userResponse = await http.get(
              Uri.https('api.github.com', '/user'),
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            );

            if (userResponse.statusCode == 200) {
              final userData = jsonDecode(userResponse.body);
              final username = userData['login'];
              print('GitHub Username: $username');
            }
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub OAuth2 Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _authenticateWithGitHub,
          child: Text('Authenticate with GitHub'),
        ),
      ),
    );
  }
}

*/