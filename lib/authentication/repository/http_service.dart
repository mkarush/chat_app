import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpProvider {
  final checkArgs =
      const String.fromEnvironment('apiServer', defaultValue: '127.0.0.1:5000');

  Future<dynamic> fetchLogin(username, password) async {
    try {
      var uri = Uri.http(checkArgs, "/login");
      var body = {"username": username, "password": password};
      final response = await http
          .post(uri, body: body, headers: {"ContentType": "application/json"});
      if (response.statusCode != 200) {
        return "${response.statusCode}";
      }
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData[0];
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> postRegister(username, password) async {
    try {
      var uri = Uri.http(checkArgs, "/register");
      var body = {"username": username, "password": password};
      final response = await http
          .post(uri, body: body, headers: {"ContentType": "application/json"});
      if (response.statusCode != 200) {
        return "${response.statusCode}";
      }
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData[0];
      }
    } catch (e) {
      return e;
    }
  }
}
