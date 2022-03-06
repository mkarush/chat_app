part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.username = const Username.pure(),
        this.password = const Password.pure(),
        this.status = FormzStatus.pure});

  final Username username;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [status, username, password];

  LoginState copyWith(
      {FormzStatus? status, Username? username, Password? password}) {
    return LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password);
  }
}
