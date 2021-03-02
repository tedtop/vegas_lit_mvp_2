import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:vegas_lit/data/repositories/sportsfeed_repository.dart';

import 'app.dart';
import 'observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MyApp(
      sportsfeedRepository: SportsfeedRepository(),
      authenticationRepository: AuthenticationRepository(),
    ),
  );
}
