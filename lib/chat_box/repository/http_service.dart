import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:import_chat_app/chat_box/model/chat_model.dart';


class HttpChatProvider {
  final checkArgs = const String.fromEnvironment('apiServer', defaultValue: '127.0.0.1:5000');

  Future fetchMessage(tag) async {
    try {
      final queryParameters = {
        'tag': tag,
      };
      var uri = Uri.http(checkArgs, "/messaging", queryParameters);
      final response =
      await http.get(uri, headers: {"ContentType": "application/json"});
      if (response.statusCode != 200) {
        return "${response.statusCode}";
      }
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<ChatModel> data =  jsonResponse.map((job) => ChatModel.fromJson(job)).toList();
        return data;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> postMessage(tag, data, username) async {
    try {
      var uri = Uri.http(checkArgs, "/messaging");
      var body = {"username": username, "tag": tag, "data": data};
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