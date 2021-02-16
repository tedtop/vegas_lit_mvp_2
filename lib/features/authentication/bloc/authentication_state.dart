part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  halfauthenticated,
  splashscreen,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.splashscreen,
    this.currentUser,
    this.currentUserData,
  });

  const AuthenticationState.splashscreen() : this._();

  const AuthenticationState.authenticated(UserData userData)
      : this._(
            status: AuthenticationStatus.authenticated,
            currentUserData: userData);

  const AuthenticationState.halfauthenticated(User user)
      : this._(
            status: AuthenticationStatus.halfauthenticated, currentUser: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final User currentUser;
  final UserData currentUserData;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [currentUser, currentUserData, status];
}
