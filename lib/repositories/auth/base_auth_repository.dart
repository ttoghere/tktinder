import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<auth.User?> signUp({
    required String email,
    required String password,
  });
}
