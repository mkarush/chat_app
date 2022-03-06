import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:import_chat_app/authentication/login/blocs/login_bloc.dart';
import 'package:import_chat_app/authentication/presentation/login_page.dart';
import 'package:import_chat_app/authentication/register/blocs/register_bloc.dart';
import 'package:import_chat_app/chat_box/blocs/chat_bloc.dart';
import 'package:import_chat_app/constants/constants.dart';
import 'package:import_chat_app/users/blocs/user_bloc.dart';

void main() {
  runApp(
    const MyConstants(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        RepositoryProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(),
        ),
        RepositoryProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        RepositoryProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
          home: const LoginPage()),
    );
  }
}
