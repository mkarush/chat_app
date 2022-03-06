class ChatModel {
  ChatModel({required this.username, required this.tag, required this.data});

  String username;
  String tag;
  String data;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        username: json["username"],
        tag: json["tag"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "tag": tag,
        "data": data,
      };
}
