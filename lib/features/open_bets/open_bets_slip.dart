import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/open_bets.dart';

class OpenBetsSlip extends StatelessWidget {
  const OpenBetsSlip({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final OpenBets openBets;

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
                        openBets.away,
                        style: Styles.awayTeam,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _betButtonSeparator(text: '@', style: Styles.h1),
                    Expanded(
                      child: Text(
                        openBets.home,
                        style: Styles.homeTeam,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          openBets.type,
                          style: GoogleFonts.nunito(),
                        ),
                        Text(
                          openBets.mlAmount.toString(),
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
                          '\$${openBets.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
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
                          '\$${openBets.win.toStringAsFixed(2)}',
                          style: Styles.homeTeam,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.nunito(
                      color: Palette.white,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Starting in ',
                      ),
                      const TextSpan(
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
