import 'package:flutter/material.dart';

class Interstitial extends StatelessWidget {
  const Interstitial._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const Interstitial._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Interstitial Ad'),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              child: const Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
