import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:formz/formz.dart';
import 'package:vegas_lit/features/authentication/screens/sign_up/sign_up.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(
          context.read<AuthenticationRepository>(),
        ),
        child: const LoginPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.loginPageColor,
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Authentication Failure',
                ),
              ),
            );
          }
        },
        child: SafeArea(
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _TopLogo(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        _EmailInput(),
                        const SizedBox(height: 10),
                        _PasswordInput(),
                        const SizedBox(height: 30),
                        _LoginButton(),
                        const SizedBox(height: 50),
                        _SocialLoginList(),
                      ],
                    ),
                  ),
                  _SignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            'Welcome to',
            style: GoogleFonts.nunito(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
          Expanded(
            child: Hero(
              tag: 'top_logo',
              child: Image.asset(
                Images.topLogo,
                height: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          width: width / 1.5,
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.nunito(),
            decoration: InputDecoration(
              prefixIcon: const Icon(LineAwesomeIcons.user),
              labelText: 'Email/Username',
              helperText: '',
              errorText: state.email.invalid ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
          width: width / 1.5,
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            style: GoogleFonts.nunito(),
            decoration: InputDecoration(
              prefixIcon: const Icon(LineAwesomeIcons.lock),
              labelText: 'Password',
              helperText: '',
              errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                key: const Key('loginForm_continue_raisedButton'),
                padding:
                    EdgeInsets.symmetric(horizontal: width / 6, vertical: 12),
                child: const Text('Log In'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Palette.green,
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _SocialLoginList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Or use any of these social platforms to log in.',
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              key: const Key('loginForm_facebookLogin_iconButton'),
              icon: const Icon(LineAwesomeIcons.facebook_square),
              iconSize: 40,
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Coming Soon!'),
                    ),
                  );
              },
            ),
            IconButton(
              key: const Key('loginForm_appleLogin_iconButton'),
              icon: const Icon(LineAwesomeIcons.apple),
              iconSize: 40,
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Coming Soon!'),
                    ),
                  );
              },
            ),
            IconButton(
              key: const Key('loginForm_googleLogin_iconButton'),
              icon: const Icon(LineAwesomeIcons.google_logo),
              iconSize: 40,
              onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
            ),
          ],
        )
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account yet? ',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
        TextButton(
          key: const Key('loginForm_createAccount_flatButton'),
          onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
          child: Text(
            'Sign Up',
            style: GoogleFonts.nunito(
              color: Palette.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
