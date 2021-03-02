import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:vegas_lit/data/repositories/sportsfeed_repository.dart';

import 'constants/themes.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/authentication/screens/fill_login/view/fill_login_page.dart';
import 'features/authentication/screens/login/view/login_page.dart';
import 'features/authentication/screens/splash/view/splash_page.dart';
import 'features/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    @required this.authenticationRepository,
    @required this.sportsfeedRepository,
  })  : assert(
          authenticationRepository != null,
          sportsfeedRepository != null,
        ),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final SportsfeedRepository sportsfeedRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider.value(
          value: sportsfeedRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Vegas Lit',
      theme: Themes.light,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.halfauthenticated:
                _navigator.push<void>(
                  LoginInfoPage.route(
                    currentUser: state.user,
                  ),
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
