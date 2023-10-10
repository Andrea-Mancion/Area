import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

String accessToken = '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Spotify Authentication'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: function,
            child: Text('Authenticate with Spotify'),
          ),
        ),
      ),
    );
  }
}

void function() async {
  final spotifyClientId = 'fdbe5e5dbe5c42b680efb3ab1d3574af';
  final callbackUrlScheme = 'mobile';

  final url = Uri.https('accounts.spotify.com', '/authorize', {
    'response_type': 'code',
    'client_id': spotifyClientId,
    'callbackUrlScheme': "mobile",
    'redirect_uri': 'mobile:/',
    'scope': 'user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public',
    'grant_type': 'authorization_code',
  });
  print(url);

  try {
    final result = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: callbackUrlScheme);

    final code = Uri.parse(result).queryParameters['code'];

    final Uri tokenUri = Uri.parse('https://accounts.spotify.com/api/token');
    final response = await http.post(
      tokenUri,
      body: {
        'client_id': spotifyClientId,
        'client_secret': '8f5b9b576da44c32bf53b1fa53786b8f',
        'redirect_uri': 'mobile:/',
        'grant_type': 'authorization_code',
        'code': code,
        'scope': 'user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public',
      },
      headers: {"content-type": "application/x-www-form-urlencoded"},
    );

    accessToken = jsonDecode(response.body)['access_token'] as String;
    print("access token:");
    print(accessToken);
  } catch (e) {
    print('Error: $e');
  }
}

void send_post_request_check_new_episode() async {

}