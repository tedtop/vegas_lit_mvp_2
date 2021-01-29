import 'package:flutter/material.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:vegas_lit/data/models/game.dart';

class BetSlipCard extends StatelessWidget {
  final Game game;

  const BetSlipCard({Key key, this.game}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Card(
        elevation: Styles.elevation,
        color: Palette.darkGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // '${game.teams.away.team} ${game.teams.away.mascot} vs ${game.teams.home.team} ${game.teams.home.mascot}',
                  '${game.teams.away.mascot} vs ${game.teams.home.mascot}',
                  style: Styles.h2,
                ),
                const Text(
                  'Starts in 20h 20m 20s',
                  style: TextStyle(color: Palette.red),
                ),
                Row(
                  children: [
                    Center(
                      child: Container(
                        // Padding inside BetButton(s)
                        padding: const EdgeInsets.all(10.0),
                        // elevation: MyStyles.elevation,
                        color: Palette.green,
                        child: const Text('BET BEARS TO WIN'),
                        // onPressed: () => {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
