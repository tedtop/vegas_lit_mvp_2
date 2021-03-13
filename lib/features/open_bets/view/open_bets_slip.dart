import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/open_bets.dart';
import '../../widgets/generic_card.dart';

class OpenBetsSlip extends StatelessWidget {
  const OpenBetsSlip({
    Key key,
    @required this.openBets,
  })  : assert(openBets != null),
        super(key: key);

  final OpenBets openBets;

  @override
  Widget build(BuildContext context) {
    return GenericCard(
      widgets: [
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
              color: Palette.cream,
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
