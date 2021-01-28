import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MyApp(),
  );
}
