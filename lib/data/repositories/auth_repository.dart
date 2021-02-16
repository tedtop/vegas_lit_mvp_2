import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegas_lit/data/models/user.dart';
import 'package:vegas_lit/data/providers/authentication.dart';
import 'package:vegas_lit/data/providers/database.dart';
import 'package:vegas_lit/data/providers/storage.dart';

class AuthenticationRepository {
  final _authenticationProvider = AuthenticationProvider();
  final _databaseProvider = DatabaseProvider();
  final _storageProvider = StorageProvider();

  Future<void> signInWithGoogle() => _authenticationProvider.signInWithGoogle();
  Future<void> signUp({String email, String password}) =>
      _authenticationProvider.signUp(email: email, password: password);
  Future<void> logInWithEmailAndPassword({String email, String password}) =>
      _authenticationProvider.logInWithEmailAndPassword(
          email: email, password: password);
  Future<void> signOutUser() => _authenticationProvider.signOutUser();
  Future<User> getCurrentUser() => _authenticationProvider.getCurrentUser();
  Stream<User> get getUser => _authenticationProvider.getUser;

  Future<void> saveDetailsFromAuthentication(User currentAuthenticatedUser) =>
      _databaseProvider.saveDetailsFromAuthentication(currentAuthenticatedUser);
  Future<void> saveUserDetails(
          {String currentUserId,
          String profileImageURL,
          String username,
          int age}) =>
      _databaseProvider.saveUserDetails(
        currentUserId: currentUserId,
        profileImageURL: profileImageURL,
        username: username,
        age: age,
      );
  Future<UserData> isProfileComplete(String currentUserId) =>
      _databaseProvider.isProfileComplete(currentUserId);

  Future<String> uploadFile(File file, String path) =>
      _storageProvider.uploadFile(file, path);
}
