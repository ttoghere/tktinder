import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tktinder/repositories/auth/auth_repository.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _auth;

  SignupCubit({required AuthRepository authRepository})
      : _auth = authRepository,
        super(SignupState.initial());

  void emailChanged({required String value}) {
    emit(
      state.copyWith(email: value, status: SignupStatus.initial),
    );
  }

  void passwordChanged({required String value}) {
    emit(
      state.copyWith(password: value, status: SignupStatus.initial),
    );
  }

  void signupWithCredentials() async {
    if (state.isValid == false) return;
    try {
      await _auth.signUp(
        email: state.email,
        password: state.password,
      );
      emit(
        state.copyWith(status: SignupStatus.success),
      );
    } catch (_) {}
  }
}
