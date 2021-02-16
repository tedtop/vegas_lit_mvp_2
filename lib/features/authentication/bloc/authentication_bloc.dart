import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/user.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(
          const AuthenticationState.splashscreen(),
        ) {
    _userSubscription = _authenticationRepository.getUser.listen(
      (user) => add(
        AuthenticationUserChanged(user),
      ),
    );
  }

  StreamSubscription<User> _userSubscription;
  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      if (event.user != null) {
        add(
          CheckProfileComplete(event.user),
        );
      } else {
        yield const AuthenticationState.unauthenticated();
      }
    } else if (event is CheckProfileComplete) {
      yield* _checkProfileComplete(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.signOutUser());
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Stream<AuthenticationState> _checkProfileComplete(
      CheckProfileComplete event) async* {
    yield const AuthenticationState.splashscreen();
    final isProfileComplete = await _authenticationRepository.isProfileComplete(
      event.user.uid,
    );
    if (isProfileComplete != null) {
      yield AuthenticationState.authenticated(isProfileComplete);
    } else {
      yield AuthenticationState.halfauthenticated(event.user);
    }
  }
}
