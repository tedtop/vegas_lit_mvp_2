import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:vegas_lit/features/authentication/screens/sign_up/cubit/sign_up_cubit.dart';

import '../sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SignUpPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Palette.signUpPageColor,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(
            context.read<AuthenticationRepository>(),
          ),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
