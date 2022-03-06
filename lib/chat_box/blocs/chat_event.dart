part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatEvent {
  final String tag;

  const ChatInitial({required this.tag});

  @override
  List<Object> get props => [tag];
}

class ChatPostValues extends ChatEvent {
  final String? tag;
  final String? data;
  final String? username;

  const ChatPostValues(
      {required this.tag, required this.data, required this.username});

  @override
  List<Object> get props => [tag!, data!, username!];
}
