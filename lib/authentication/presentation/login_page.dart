import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:import_chat_app/authentication/login/blocs/login_bloc.dart';
import 'package:import_chat_app/authentication/presentation/register_page.dart';
import 'package:import_chat_app/authentication/styling/styling.dart';
import 'package:import_chat_app/authentication/widgets/elevated_button.dart';
import 'package:import_chat_app/authentication/widgets/textform_field.dart';
import 'package:import_chat_app/constants/constants.dart';
import 'package:import_chat_app/users/presentation/users_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => UserPage(username: state.username.value)),
            (Route<dynamic> route) => false,
          );
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(MyConstants.of(context)!.errorTitle),
            ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(MyConstants.of(context)!.loginText, style: appBarTextStyle),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AspectRatio(
                          aspectRatio: 2 / 1,
                          child:
                              Image.asset(MyConstants.of(context)!.logoImage)),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.username != current.username,
                      builder: (context, state) {
                        return TextForm(
                          controller: usernameController,
                          hintText: MyConstants.of(context)!.usernameField,
                          validator: (value) => state.username.invalid
                              ? null
                              : MyConstants.of(context)!.usernameError,
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(LoginUsernameChanged(username: value!)),
                        );
                      },
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.password != current.password,
                      builder: (context, state) {
                        return TextForm(
                          controller: passwordController,
                          hintText: MyConstants.of(context)!.passwordField,
                          validator: (value) => state.password.invalid
                              ? null
                              : MyConstants.of(context)!.passwordError,
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(LoginPasswordChanged(password: value)),
                          obscureText: true,
                        );
                      },
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        if (state.status.isSubmissionInProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ElevatedButtonField(
                            onTap: state.status.isValidated
                                ? () => context
                                    .read<LoginBloc>()
                                    .add(const LoginButtonSubmitted())
                                : null,
                            text: MyConstants.of(context)!.loginText,
                          );
                        }
                      },
                    ),
                    ElevatedButtonField(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        ),
                      },
                      text: MyConstants.of(context)!.registerText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
