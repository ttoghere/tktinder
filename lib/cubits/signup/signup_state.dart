// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final SignupStatus status;
  const SignupState(
    this.email,
    this.password,
    this.status,
  );
  factory SignupState.initial() {
    return const SignupState("", "", SignupStatus.initial);
  }
  @override
  List<Object?> get props => [email, password, status];

  SignupState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
  }) {
    return SignupState(
      email ?? this.email,
      password ?? this.password,
      status ?? this.status,
    );
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;
}
