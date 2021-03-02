import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:vegas_lit/constants/assets.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:vegas_lit/features/authentication/bloc/authentication_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../cubit/fill_login_cubit.dart';

class LoginInfoPage extends StatefulWidget {
  const LoginInfoPage._({
    Key key,
    @required User currentUser,
  })  : assert(currentUser != null),
        _currentUser = currentUser,
        super(key: key);

  static Route route({@required User currentUser}) {
    return MaterialPageRoute<void>(
      builder: (context) => BlocProvider(
        create: (_) => FillLoginCubit(
          context.read<AuthenticationRepository>(),
        ),
        child: LoginInfoPage._(
          currentUser: currentUser,
        ),
      ),
    );
  }

  final User _currentUser;

  @override
  _LoginInfoPageState createState() => _LoginInfoPageState();
}

class _LoginInfoPageState extends State<LoginInfoPage>
    with WidgetsBindingObserver {
  File profileImageFile;

  ImageProvider profileImage = Image.asset(Images.placeholderImage).image;

  ImageProvider uploadProfileImage;

  ImagePicker _picker;

  int age = 18;

  final TextEditingController _usernameController = TextEditingController();

  var isOpenKeyboard = false;

  @override
  void initState() {
    _picker = ImagePicker();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<FillLoginCubit, FillLoginState>(
        listener: (context, state) {
          if (state is FillLoginFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Login Failure'),
                ),
              );
          }
          if (state is FillLoginSuccess) {
            context.read<AuthenticationBloc>().add(
                  CheckProfileComplete(
                    widget._currentUser,
                  ),
                );
          }
        },
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildProfilePictureWidget(),
                Column(
                  children: [
                    const Text(
                      'How old are you?',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildAgePicker(),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Choose a username',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    _buildUsernameWidget()
                  ],
                ),
                _buildSaveButtonWidget(),
                const LogOutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureWidget() {
    return GestureDetector(
      onTap: pickImage,
      child: CircleAvatar(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.camera,
              color: Colors.black,
              size: 15,
            ),
            const Text(
              'Set Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 10),
            )
          ],
        ),
        backgroundImage: uploadProfileImage ?? profileImage,
        backgroundColor: Colors.white,
        radius: 60,
      ),
    );
  }

  Future pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    profileImageFile = File(pickedFile.path);
    setState(
      () {
        if (pickedFile != null) {
          uploadProfileImage = Image.file(
            File(pickedFile.path),
          ).image;
        }
      },
    );
  }

  Future<File> imageToFile({String path}) async {
    final bytes = await rootBundle.load(path);
    final tempPath = (await getTemporaryDirectory()).path;
    final file = File('$tempPath/profile.png');
    await file.writeAsBytes(
      bytes.buffer.asUint8List(
        bytes.offsetInBytes,
        bytes.lengthInBytes,
      ),
    );
    return file;
  }

  Widget _buildAgePicker() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        NumberPicker.horizontal(
            initialValue: age,
            minValue: 15,
            maxValue: 50,
            highlightSelectedValue: true,
            onChanged: (num value) {
              setState(() {
                age = value as int;
              });
            }),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'Years',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget _buildUsernameWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 120,
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        controller: _usernameController,
        decoration: InputDecoration(
          hintText: '@username',
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
            width: 0.1,
          )),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButtonWidget() {
    return BlocBuilder<FillLoginCubit, FillLoginState>(
      builder: (context, state) {
        if (state is FillLoginInProgress) {
          return const CircularProgressIndicator(
            strokeWidth: 2.0,
          );
        }
        if (state is FillLoginSuccess) {
          return const Text('Saved');
        } else {
          return FloatingActionButton(
            onPressed: () => {
              if (
              // profileImageFile != null &&
              age != null && _usernameController.text.isNotEmpty)
                {
                  FocusScope.of(context).requestFocus(
                    FocusNode(),
                  ),
                  context.read<FillLoginCubit>().saveProfile(
                      age: age,
                      currentUser: widget._currentUser,
                      profileImage: profileImageFile,
                      username: _usernameController.text),
                }
              else
                {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Please Fill all the Details'),
                      ),
                    ),
                }
            },
            elevation: 0,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.done,
              color: Theme.of(context).accentColor,
            ),
          );
        }
      },
    );
  }

  @override
  void didChangeMetrics() {
    final value = MediaQuery.of(context).viewInsets.bottom;
    if (value > 0) {
      if (isOpenKeyboard) {
        onKeyboardChanged(false);
      }
      isOpenKeyboard = false;
    } else {
      isOpenKeyboard = true;
      onKeyboardChanged(true);
    }
  }

  void onKeyboardChanged(bool isVisible) {
    if (!isVisible) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AuthenticationBloc>().add(
            AuthenticationLogoutRequested(),
          ),
      child: const Text(
        'Login with another account?',
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
