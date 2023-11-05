import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';

const String dropboxClientId = 'aovpzza7354cn7d';
const String dropboxClientSecret = 'sblrd1uw8chxzfz';
String redirectUri = 'mobile://oauth2-callback';
String customUriScheme = 'mobile';
String codeVerifier = '';
String codeChallenge = '';

void dropboxAuthentication() {
  codeVerifier = generateCodeVerifier();
  codeChallenge = generateCodeChallenge(codeVerifier);

  dropboxAuthentication2();
}

String generateCodeVerifier() {
  const String charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
  return List.generate(
      128, (i) => charset[Random.secure().nextInt(charset.length)]).join();
}

String generateCodeChallenge(String codeVerifier) {
  var bytes = utf8.encode(codeVerifier);
  var digest = sha256.convert(bytes);
  String codeChallenge = base64Url
      .encode(digest.bytes)
      .replaceAll("=", "")
      .replaceAll("+", "-")
      .replaceAll("/", "_");
  return codeChallenge;
}

void dropboxAuthentication2() async {
  if (AllVariables.accessToken["Dropbox"] != '') {
    return;
  }
  final url = Uri.https('www.dropbox.com', 'oauth2/authorize', {
    'response_type': 'code',
    'client_id': dropboxClientId,
    'redirect_uri': redirectUri,
    'scope': 'account_info.read files.content.read files.content.write files.metadata.read',
    'code_challenge': codeChallenge,
    'code_challenge_method': 'S256',
  });

  try {
    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: customUriScheme);

    final code = Uri.parse(result).queryParameters['code'];
    final url2 = Uri.https('api.dropboxapi.com', 'oauth2/token');
    final response = await http.post(
      url2,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirectUri,
        "client_id": dropboxClientId,
        "client_secret": dropboxClientSecret,
        "code_verifier": codeVerifier,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      AllVariables.accessToken["Dropbox"] = jsonResponse["access_token"];
      print("Discord access token: ${jsonResponse['access_token']}");
    } else {
      print('Error: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error: $e');
  }
}