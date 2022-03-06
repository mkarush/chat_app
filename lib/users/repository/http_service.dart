import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:import_chat_app/users/model/get_users.dart';

class HttpUserProvider {
  final checkArgs = const String.fromEnvironment('apiServer', defaultValue: '127.0.0.1:5000');

  Future getUsers() async {
    try {
      var uri = Uri.http(checkArgs, "/users");
      final response =
      await http.get(uri, headers: {"ContentType": "application/json"});
      if (response.statusCode != 200) {
        return "${response.statusCode}";
      }
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<UserModel> data =  jsonResponse.map((job) => UserModel.fromJson(job)).toList();
        return data;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
