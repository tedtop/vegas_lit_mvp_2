import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/constants/assets.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/features/authentication/screens/login/login.dart';
import 'package:vegas_lit/features/authentication/screens/sign_up/sign_up.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Sign Up Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TopLogo(),
            Column(
              children: [
                _EmailInput(),
                _PasswordInput(),
                _ConfirmPasswordInput(),
                _SignUpButton(),
              ],
            ),
            Column(
              children: [
                _SocialLoginList(),
                _AlreadyAccount(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to',
          style: GoogleFonts.nunito(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        Hero(
          tag: 'top_logo',
          child: Image.asset(
            Images.topLogo,
            height: 70,
          ),
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          height: height / 12,
          width: width / 1.5,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Email Address',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: height / 16,
                  child: TextField(
                    style: GoogleFonts.nunito(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                    key: const Key('signUpForm_emailInput_textField'),
                    onChanged: (email) =>
                        context.read<SignUpCubit>().emailChanged(email),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 8,
                      ),
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                      border: const OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      isDense: true,
                      hintText: 'Email Address',
                      helperText: '',
                      errorText: state.email.invalid ? 'invalid email' : null,
                    ),
                  ),
                ),
              ),
            ],
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
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
          height: height / 12,
          width: width / 1.5,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Password',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: height / 16,
                  child: TextField(
                    key: const Key('signUpForm_passwordInput_textField'),
                    onChanged: (password) =>
                        context.read<SignUpCubit>().passwordChanged(password),
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 8,
                      ),
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                      border: const OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      isDense: true,
                      hintText: 'Password',
                      helperText: '',
                      errorText:
                          state.password.invalid ? 'invalid password' : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return SizedBox(
          height: height / 12,
          width: width / 1.5,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Verify Password',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: height / 16,
                  child: TextField(
                    key: const Key(
                        'signUpForm_confirmedPasswordInput_textField'),
                    onChanged: (confirmPassword) => context
                        .read<SignUpCubit>()
                        .confirmedPasswordChanged(confirmPassword),
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 8,
                      ),
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      isDense: true,
                      hintText: 'Verify Password',
                      helperText: '',
                      errorText: state.confirmedPassword.invalid
                          ? 'passwords do not match'
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RaisedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                child: const Text('SIGN UP'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.orangeAccent,
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
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
          'Or use any of these social platforms to sign up.',
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
              icon: const Icon(FontAwesomeIcons.facebook),
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
              icon: const Icon(FontAwesomeIcons.apple),
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
              icon: const Icon(FontAwesomeIcons.google),
              iconSize: 40,
              onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
            ),
          ],
        )
      ],
    );
  }
}

class _AlreadyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextButton(
          key: const Key('loginForm_createAccount_flatButton'),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Log In',
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
