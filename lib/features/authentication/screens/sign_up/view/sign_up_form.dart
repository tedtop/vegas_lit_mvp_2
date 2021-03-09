import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/authentication/screens/login/login.dart';
import 'package:vegas_lit/features/authentication/screens/sign_up/sign_up.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TopLogo(),
              Column(
                children: [
                  _ExistingAccountSignIn(),
                  _UsernameInput(),
                  _EmailInput(),
                  _PasswordInput(),
                  _ConfirmPasswordInput(),
                  _StateInput(),
                  _MobileNumberInput(),
                  _AgeCheckbox(),
                  _RulesCheckbox(),
                  _SignUpButton(),
                  _SocialLoginList(),
                ],
              ),
            ],
          ),
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
            height: 80,
          ),
        ),
      ],
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Username',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Palette.white,
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_usernameInput_textField'),
                onChanged: print,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Username',
                  helperText: '',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
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
              child: TextField(
                cursorColor: Palette.white,
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
                    vertical: 4,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Email Address',
                  helperText: '',
                  errorText: state.email.invalid ? 'Invalid email' : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
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
              child: TextField(
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_passwordInput_textField'),
                onChanged: (password) =>
                    context.read<SignUpCubit>().passwordChanged(password),
                obscureText: true,
                cursorColor: Palette.white,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
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
                  hintText: 'Password',
                  helperText: '',
                  errorText: state.password.invalid
                      ? 'Password should be 8 characters and include at least one number'
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
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
              child: TextField(
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_confirmedPasswordInput_textField'),
                onChanged: (confirmPassword) => context
                    .read<SignUpCubit>()
                    .confirmedPasswordChanged(confirmPassword),
                obscureText: true,
                cursorColor: Palette.white,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
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
                      ? 'Passwords do not match'
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'State',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                cursorColor: Palette.white,
                key: const Key('signUpForm_stateInput_textField'),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIconConstraints:
                      const BoxConstraints(maxHeight: 10, maxWidth: 25),
                  suffixIcon: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: const Icon(LineAwesomeIcons.angle_down),
                    iconSize: 10,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'State',
                  helperText: '',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MobileNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Mobile Number',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_mobileNumberInput_textField'),
                onChanged: print,
                cursorColor: Palette.white,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Mobile Number',
                  helperText: '',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AgeCheckbox extends StatefulWidget {
  @override
  __AgeCheckboxState createState() => __AgeCheckboxState();
}

class __AgeCheckboxState extends State<_AgeCheckbox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          fillColor: MaterialStateProperty.all(Palette.green),
          value: isSelected,
          onChanged: (value) {
            setState(
              () {
                isSelected = value;
              },
            );
          },
        ),
        Text(
          'I am 18 years or older',
          style: GoogleFonts.nunito(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _RulesCheckbox extends StatefulWidget {
  @override
  __RulesCheckboxState createState() => __RulesCheckboxState();
}

class __RulesCheckboxState extends State<_RulesCheckbox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          fillColor: MaterialStateProperty.all(Palette.green),
          value: isSelected,
          onChanged: (value) {
            setState(
              () {
                isSelected = value;
              },
            );
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                        text:
                            'I have read and agree to the official Vegas Lit contest rules and conditions found '),
                    const TextSpan(
                      text: 'here',
                      style: TextStyle(color: Palette.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : RaisedButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 12,
                  ),
                  key: const Key('signUpForm_continue_raisedButton'),
                  child: const Text('SIGN UP'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  color: Palette.green,
                  onPressed: state.status.isValidated
                      ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                      : null,
                );
        },
      ),
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
            fontSize: 17,
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

class _ExistingAccountSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
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
              color: Palette.green,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
