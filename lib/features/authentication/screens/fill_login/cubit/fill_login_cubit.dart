import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';

part 'fill_login_state.dart';

class FillLoginCubit extends Cubit<FillLoginState> {
  FillLoginCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(
          FillLoginInitial(),
        );

  final AuthenticationRepository _authenticationRepository;

  Future<void> saveProfile({
    @required File profileImage,
    @required int age,
    @required String username,
    @required User currentUser,
  }) async {
    emit(FillLoginInProgress());
    try {
      final profilePictureURL = await _authenticationRepository.uploadFile(
        profileImage,
        'profile_pictures/${'$username'}',
      );
      await _authenticationRepository.saveDetailsFromAuthentication(
        currentUser,
      );
      await _authenticationRepository.saveUserDetails(
        currentUserId: currentUser.uid,
        profileImageURL: profilePictureURL,
        age: age,
        username: username,
      );
      emit(FillLoginSuccess());
    } on Exception {
      emit(FillLoginFailure());
    }
  }
}
