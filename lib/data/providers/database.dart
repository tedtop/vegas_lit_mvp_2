import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegas_lit/data/models/user.dart';

import '../base_provider.dart';

class DatabaseProvider extends BaseDatabaseProvider {
  DatabaseProvider({FirebaseFirestore firebaseFirestore})
      : _firestoreData = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestoreData;

  @override
  Future<void> saveDetailsFromAuthentication(
    User currentAuthenticatedUser,
  ) async {
    final userData = {
      'uid': currentAuthenticatedUser.uid,
      'name': currentAuthenticatedUser.displayName,
      'email': currentAuthenticatedUser.email,
      'googlePhoto': currentAuthenticatedUser.photoURL,
    };
    final currentUserReference = _firestoreData.collection('users').doc(
          currentAuthenticatedUser.uid,
        );
    final userEmpty = await currentUserReference.snapshots().isEmpty;
    if (userEmpty) {
      await currentUserReference.set(
        userData,
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  @override
  Future<void> saveUserDetails({
    String currentUserId,
    String profileImageURL,
    int age,
    String username,
  }) async {
    final userData = {
      'uploadPhoto': profileImageURL,
      'age': age,
      'username': username,
      'bio': '',
    };
    final currentUserReference = _firestoreData.collection('users').doc(
          currentUserId,
        );
    await currentUserReference.set(
      userData,
      SetOptions(
        merge: true,
      ),
    );
  }

  @override
  Future<UserData> isProfileComplete(String currentUserId) async {
    final currentUserReference = _firestoreData.collection('users').doc(
          currentUserId,
        );
    final currentUserDocument = await currentUserReference.get();
    final isProfileComplete = currentUserDocument != null &&
        currentUserDocument.exists &&
        currentUserDocument.data().containsKey('uid') &&
        currentUserDocument.data().containsKey('name') &&
        currentUserDocument.data().containsKey('email') &&
        currentUserDocument.data().containsKey('uploadPhoto') &&
        currentUserDocument.data().containsKey('username');
    if (isProfileComplete) {
      return UserData.fromFirestore(currentUserDocument);
    } else {
      return null;
    }
  }
}
