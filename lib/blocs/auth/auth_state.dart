// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

enum AuthStatus { unknown, authOn, authOff }

class AuthState extends Equatable {
  final AuthStatus status;
  final auth.User? user;
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  const AuthState.unknown() : this._();
  const AuthState.authOn({required auth.User user})
      : this._(
          status: AuthStatus.authOn,
          user: user,
        );
  const AuthState.authOff({required auth.User user})
      : this._(
          status: AuthStatus.authOff,
        );

  @override
  List<Object?> get props => [user, status];
}
