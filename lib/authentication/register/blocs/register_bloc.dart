import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:import_chat_app/authentication/repository/http_service.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:import_chat_app/authentication/register/model/register_model.dart';

part 'register_event.dart';
part 'register_state.dart';

HttpProvider _httpProvider = HttpProvider();

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()){
    on<RegisterUsernameChanged>(_mapUsernameChangedToState);
    on<RegisterPasswordChanged>(_mapPasswordChangedToState);
    on<RegisterButtonSubmitted>(_mapLoginSubmittedToState);
  }

  @override
  void onTransition(Transition<RegisterEvent, RegisterState> transition) {
    super.onTransition(transition);
  }

  void _mapUsernameChangedToState(
    RegisterUsernameChanged event,
      Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.password]),
    ));
  }

  void _mapPasswordChangedToState(
    RegisterPasswordChanged event,
      Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password!);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.username, password]),
    ));
  }

  void _mapLoginSubmittedToState(
    RegisterButtonSubmitted event,
      Emitter<RegisterState> emit,
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
        await _httpProvider.postRegister(state.username.value, state.password.value);
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
