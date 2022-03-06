import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:import_chat_app/chat_box/repository/http_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

HttpChatProvider _httpChatProvider = HttpChatProvider();

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState()) {
    on<ChatInitial>((event, emit) async {
      emit(ChatLoading());
      try {
        List<dynamic> user = await _httpChatProvider.fetchMessage(event.tag);
        emit(ChatSuccessState(values: user));
      } catch (e) {
        emit(ChatFailure(message: e.toString()));
      }
    });
    on<ChatPostValues>((event, emit) async {
      try {
        await _httpChatProvider.postMessage(event.tag, event.data, event.username);
        List<dynamic> data = await _httpChatProvider.fetchMessage(event.tag);
        emit(ChatSuccessState(values: data));
      } catch (e) {
        emit(ChatFailure(message: e.toString()));
      }
    });
  }
}