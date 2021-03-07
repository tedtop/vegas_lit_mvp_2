import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:intl/intl.dart';

class OpenBetsSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
      ),
      child: Card(
        elevation: Styles.elevation,
        color: Palette.darkGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'BEARS',
                        style: Styles.awayTeam,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _betButtonSeparator(text: '@', style: Styles.h1),
                    Expanded(
                      child: Text(
                        'TITANS',
                        style: Styles.homeTeam,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'MONEYLINE',
                          style: GoogleFonts.nunito(),
                        ),
                        Text(
                          '-242',
                          style: Styles.awayTeam,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'RISK',
                          style: GoogleFonts.nunito(),
                        ),
                        Text(
                          '\$50.00',
                          style: TextStyle(
                            color: Palette.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'TO WIN',
                          style: GoogleFonts.nunito(),
                        ),
                        Text(
                          '-242',
                          style: Styles.homeTeam,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.nunito(
                      color: Palette.white,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Starting in ',
                      ),
                      TextSpan(
                        text: '20hr:17m:18s',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _betButtonSeparator({
  String text,
  TextStyle style,
}) {
  return SizedBox(
    width: 100,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: style ?? Styles.h3,
    ),
  );
}
