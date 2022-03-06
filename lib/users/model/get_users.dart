class UserModel {
  UserModel({
    required this.username,
  });

  String username;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
