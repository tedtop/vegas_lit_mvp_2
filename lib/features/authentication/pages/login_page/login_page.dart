import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:formz/formz.dart';
import 'cubit/login_cubit.dart';
import 'widgets/google_login_button.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Authentication Failure'),
                  ),
                );
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const FlutterLogo(
                  size: 100,
                ),
                const GoogleLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
