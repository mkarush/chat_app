part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState(
      {this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  final Username username;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [status, username, password];

  RegisterState copyWith(
      {FormzStatus? status, Username? username, Password? password}) {
    return RegisterState(
        status: status ?? this.status,
        username: username ?? this.username,
        password: password ?? this.password);
  }
}
