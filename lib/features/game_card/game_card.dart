import 'package:flutter/material.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:vegas_lit/data/models/game.dart';

import 'widgets/bet_button.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    Key key,
    @required Game game,
  })  : assert(game != null),
        _game = game,
        super(key: key);

  final Game _game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // '${game.teams.away.team} ${game.teams.away.mascot} vs ${game.teams.home.team} ${game.teams.home.mascot}',
                  '${_game.teams.away.mascot} vs ${_game.teams.home.mascot}',
                  style: Styles.h2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE, MMMM, c, y @ hh:mm a').format(
                        _game.schedule.date.toLocal(),
                      ),
                      style: Styles.h4,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Starting in',
                            style: Styles.h4,
                          ),
                          TextSpan(
                            text: '20hr:17m:18s',
                            style: Styles.startingTimeText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${_game.teams.away.mascot}',
                            style: Styles.awayTeam,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        _betButtonSeparator(text: '@', style: Styles.h1),
                        Expanded(
                          child: Text(
                            '${_game.teams.home.mascot}',
                            style: Styles.homeTeam,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        BetButton(
                          text: '${_game.odds[0].moneyline.current.awayOdds}',
                          game: _game,
                        ),
                        _betButtonSeparator(text: 'ML'),
                        BetButton(
                          game: _game,
                          text: '${_game.odds[0].moneyline.current.homeOdds}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        BetButton(
                          game: _game,
                          text:
                              '${_game.odds[0].spread.current.away}     ${_game.odds[0].spread.current.awayOdds}',
                        ),
                        _betButtonSeparator(text: 'PTS'),
                        BetButton(
                          game: _game,
                          text:
                              '${_game.odds[0].spread.current.home}     ${_game.odds[0].spread.current.homeOdds}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        BetButton(
                          game: _game,
                          text:
                              'o${_game.odds[0].total.current.total}     ${_game.odds[0].total.current.overOdds}',
                        ),
                        _betButtonSeparator(text: 'TOT'),
                        BetButton(
                          game: _game,
                          text:
                              'u${_game.odds[0].total.current.total}     ${_game.odds[0].total.current.underOdds}',
                        ),
                      ],
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
}
