import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:import_chat_app/authentication/presentation/login_page.dart';
import 'package:import_chat_app/authentication/widgets/elevated_button.dart';
import 'package:import_chat_app/chat_box/presentation/chat_message.dart';
import 'package:import_chat_app/constants/constants.dart';
import 'package:import_chat_app/users/styling/styling.dart';
import 'package:import_chat_app/users/blocs/user_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.username, Key? key}) : super(key: key);
  final String? username;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(UserFetch()),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              MyConstants.of(context)!.userAppbar,
              style: appBarTextStyle,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.exit_to_app),
              )
            ]),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserSuccessState) {
            List values = [];
            for (var element in state.username) {
              if (element.username.toString() != widget.username) {
                values.add(element.username.toString());
              }
            }
            return ListView.builder(
                itemCount: values.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 10,
                    child: ListTile(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    chatUserName: values[index],
                                    loginUsername: widget.username,
                                  )),
                        ),
                      },
                      leading: const Icon(Icons.person_pin, size: iconSize),
                      title: Text(
                        values[index],
                        style: userTextStyle,
                      ),
                    ),
                  );
                });
          } else if (state is UserFailure) {
            return Center(
              child: ElevatedButtonField(
                  onTap: null, text: state.message.toString()),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
