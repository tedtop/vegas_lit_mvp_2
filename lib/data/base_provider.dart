import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

abstract class BaseAuthenticationProvider {
  Future<void> signInWithGoogle();
  Future<void> signUp({String email, String password});
  Future<void> logInWithEmailAndPassword({String email, String password});
  Future<void> signOutUser();
  Future<User> getCurrentUser();
  Stream<User> getUser;
}

abstract class BaseDatabaseProvider {
  Future<void> saveDetailsFromAuthentication(User currentAuthenticatedUser);
  Future<void> saveUserDetails(
      {String currentUserId, String profileImageURL, String username, int age});
  Future<UserData> isProfileComplete(String currentUserId);
}

abstract class BaseStorageProvider {
  Future<String> uploadFile(File file, String path);
}
