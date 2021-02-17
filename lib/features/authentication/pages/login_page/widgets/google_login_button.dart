import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegas_lit/features/authentication/pages/login_page/cubit/login_cubit.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  OutlineButton.icon(
                    label: const Text(
                      'SIGN IN WITH GOOGLE',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        context.read<LoginCubit>().logInWithGoogle(),
                  ),
                ],
              );
      },
    );
  }
}
