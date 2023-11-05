import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_app/variable.dart';

void gitlabAuthentication() async {
  final gitlabClientId = '362bf2292f1f5739f0fe57337aba09b9bd4da16c39bead6ac58afad19201ddde';
  final gitlabClientSecret = 'gloas-50c571e7f506a683c7ddcd00a4628c95547a6a041878b9443bcca98eeda3e511';
  final callbackUrlScheme = 'mobile';

  if (AllVariables.accessToken["Gitlab"] != '') {
    return;
  }
  final url = Uri.https('gitlab.com', '/oauth/authorize', {
    'client_id': gitlabClientId,
    'redirect_uri': 'mobile://oauth2-callback',
    'scope': 'api read_api read_user create_runner k8s_proxy read_repository write_repository read_registry write_registry read_observability write_observability ai_features sudo admin_mode openid profile email',
    'response_type': 'code',
  });

  try {
    final result = await FlutterWebAuth.authenticate(
      url: url.toString(),
      callbackUrlScheme: callbackUrlScheme,
    );

    final code = Uri.parse(result).queryParameters['code'];

    final tokenUri = Uri.https('gitlab.com', '/oauth/token');
    final response = await http.post(
      tokenUri,
      body: {
        'client_id': gitlabClientId,
        'client_secret': gitlabClientSecret,
        'code': code,
        'grant_type': 'authorization_code',
        'redirect_uri': 'mobile://oauth2-callback',
      },
      headers: {"Accept": "application/json"},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('access_token')) {
      AllVariables.accessToken["Gitlab"] = jsonDecode(response.body)['access_token'] as String;
      print("Access token gitlab: ${AllVariables.accessToken["GitLab"]}");
    } else {
      print("Error: Failed to obtain access token");
    }
  } catch (e) {
    print('Error: $e');
  }
}