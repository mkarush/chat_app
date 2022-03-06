import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:import_chat_app/users/repository/http_service.dart';

part 'user_event.dart';
part 'user_state.dart';

HttpUserProvider _httpUserProvider = HttpUserProvider();

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(): super(UserState()) {
    on<UserFetch>((event, emit) async {
      emit(UserLoading());
      try {
        List<dynamic> user = await _httpUserProvider.getUsers();
        emit(UserSuccessState(username: user));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });
  }
}
