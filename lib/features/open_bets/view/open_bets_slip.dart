import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/open_bets.dart';
import '../../widgets/generic_card.dart';

class OpenBetsSlip extends StatelessWidget {
  const OpenBetsSlip({
    Key key,
    // @required this.openBets,
  }) :
        //  assert(openBets != null),
        super(key: key);

  // final OpenBets openBets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Container(
        width: 390,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Palette.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TITANS TO WIN',
                        style: GoogleFonts.nunito(
                          fontSize: 24,
                          color: Palette.cream,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Palette.cream,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            const TextSpan(
                              text: 'BEARS',
                            ),
                            const TextSpan(text: '  @  '),
                            TextSpan(
                              text: 'TITANS',
                              style: GoogleFonts.nunito(color: Palette.green),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'MONEYLINE +100',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Palette.cream,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3.0,
                        ),
                        child: Text(
                          'You bet \$100 to win \100!',
                          style: GoogleFonts.nunito(
                            color: Palette.green,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Sunday, November 08, 2020',
                            style: GoogleFonts.nunito(
                              color: Palette.cream,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.nunito(
                                fontSize: 10,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Starting in',
                                  style: GoogleFonts.nunito(
                                    color: Palette.cream,
                                  ),
                                ),
                                TextSpan(
                                  text: '20hr:17m:18s',
                                  style: GoogleFonts.nunito(
                                    color: Palette.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Palette.lightGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/open_bets_logo.png',
                      ),
                    ),
                    height: 150,
                    width: 90,
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
