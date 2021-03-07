import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

import 'open_bets_slip.dart';

class OpenBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightGrey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'OPEN BETS',
                  style: Styles.headingLeaderboard,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(
                    fontSize: 14, fontWeight: FontWeight.w300),
                children: <TextSpan>[
                  const TextSpan(
                      text:
                          'Bets shown here cannot be modified and are awaiting the outcome of the event. Once bets have been closed they will appear in your'),
                  TextSpan(
                      text: ' BET HISTORY ',
                      style: GoogleFonts.nunito(
                        color: Palette.green,
                      )),
                  const TextSpan(text: 'page.'),
                ],
              ),
            ),
          ),
          const TextBar(
            text: 'Ascending - by start time',
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: List.generate(
                4,
                (index) => OpenBetsSlip(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 8.0,
        child: Container(
          color: Palette.darkGrey,
          padding: const EdgeInsets.all(8.0),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Styles.h3,
              ),
              const Icon(
                LineAwesomeIcons.arrow_down,
              )
            ],
          ),
        ),
      ),
    );
  }
}
