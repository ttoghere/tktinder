import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tktinder/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _auth;
  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? auth.FirebaseAuth.instance;
  @override
  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      return user;
    } on auth.FirebaseAuthException catch (authError) {
      log("Error: $authError");
    } catch (e) {
      log("Error: $e");
    }
  }

  @override
  Stream<auth.User?> get user => _auth.userChanges();
}
