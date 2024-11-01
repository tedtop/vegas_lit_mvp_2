import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        style: Styles.creamLargeBold,
                      ),
                      RichText(
                        text: TextSpan(
                          style: Styles.defaultCreamLessBold,
                          children: [
                            const TextSpan(
                              text: 'BEARS',
                            ),
                            const TextSpan(text: '  @  '),
                            TextSpan(
                              text: 'TITANS',
                              style: Styles.nunitoGreen,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'MONEYLINE +100',
                        style: Styles.defaultCreamLessBold,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3.0,
                        ),
                        child: Text(
                          'You bet \$100 to win \100!',
                          style: Styles.defaultGreen,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Sunday, November 08, 2020',
                            style: Styles.smallCream,
                          ),
                          // const SizedBox(
                          //   width: 2,
                          // ),
                          // RichText(
                          //   text: TextSpan(
                          //     style: Styles.small,
                          //     children: [
                          //       TextSpan(
                          //         text: 'Starting in',
                          //         style: Styles.creamColor,
                          //       ),
                          //       TextSpan(
                          //         text: '20hr:17m:18s',
                          //         style: Styles.redColor,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
