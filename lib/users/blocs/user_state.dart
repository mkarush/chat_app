part of 'user_bloc.dart';

class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserSuccessState extends UserState {
  final List<dynamic> username;

  UserSuccessState({required this.username});

  @override
  List<Object> get props => [username];
}

class UserFailure extends UserState {
  final String message;

  UserFailure({required this.message});

  @override
  List<Object> get props => [message];
}
