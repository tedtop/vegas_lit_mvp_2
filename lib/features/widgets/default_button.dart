import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.text,
    @required this.action,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final Function action;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 174,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: RaisedButton(
          elevation: Styles.dropShadow,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            text,
            style: Styles.greenButtonText,
          ),
          shape: Styles.buttonRadius,
          textColor: Palette.cream,
          color: Palette.green,
          onPressed: action,
        ),
      ),
    );
  }
}
