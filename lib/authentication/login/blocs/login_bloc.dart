import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:import_chat_app/authentication/login/model/login_model.dart';
import 'package:import_chat_app/authentication/repository/http_service.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

HttpProvider _httpProvider = HttpProvider();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()){
    on<LoginUsernameChanged>(_mapUsernameChangedToState);
    on<LoginPasswordChanged>(_mapPasswordChangedToState);
    on<LoginButtonSubmitted>(_mapLoginSubmittedToState);
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
  }

  void _mapUsernameChangedToState(
      LoginUsernameChanged event,
      Emitter<LoginState> emit,
      ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.password]),
    ));
  }

  void _mapPasswordChangedToState(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    final password = Password.dirty(event.password!);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.username, password]),
    ));
  }

  void _mapLoginSubmittedToState(
      LoginButtonSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      username: username,
      password: password,
      status: Formz.validate([username, password]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var fetchLogin =
        await _httpProvider.fetchLogin(state.username.value, state.password.value);
        if (fetchLogin == "success") {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));

      }
    }
  }
}