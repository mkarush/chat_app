part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;

  const RegisterUsernameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String? password;
  const RegisterPasswordChanged({required this.password});

  @override
  List<Object> get props => [password!];
}

class RegisterButtonSubmitted extends RegisterEvent {
  const RegisterButtonSubmitted();
}
