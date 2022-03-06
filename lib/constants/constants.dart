import 'package:flutter/material.dart';

class MyConstants extends InheritedWidget {
  static MyConstants? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyConstants>();

  const MyConstants({required Widget child, Key? key})
      : super(key: key, child: child);

  final String logoImage = "images/logo.jpeg";

  final String loginText = "Login";
  final String registerText = "Register";

  final String usernameField = "Enter Username";
  final String usernameError = "username is too short";

  final String passwordField = "Enter password";
  final String passwordError = "password is too short";


  final String errorTitle = "Authentication Error!";

  final String userAppbar = "User";

  final String chatBoxAppbar = "Chat";
  final String chatBoxHint = "Write a message";
  final String chatSendMessage= "Send";

  @override
  bool updateShouldNotify(MyConstants oldWidget) => false;
}
