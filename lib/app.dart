import 'package:flutter/material.dart';

import 'constants/themes.dart';
import 'features/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppView();
  }
}

class AppView extends StatefulWidget {
  AppView({Key key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vegas Lit',
      theme: Themes.light,
      home: HomePage.route(),
    );
  }
}
