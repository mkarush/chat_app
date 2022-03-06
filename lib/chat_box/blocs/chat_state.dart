part of 'chat_bloc.dart';

class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<dynamic> values;

  ChatSuccessState({required this.values});

  @override
  List<Object> get props => [values];
}

class ChatPostSuccessState extends ChatState {
  final String values;

  ChatPostSuccessState({required this.values});

  @override
  List<Object> get props => [values];
}

class ChatFailure extends ChatState {
  final String message;

  ChatFailure({required this.message});

  @override
  List<Object> get props => [message];
}
