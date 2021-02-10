import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/constants/styles.dart';

import 'cubit/game_card_cubit.dart';
import 'widgets/bet_button.dart';

class GameCard extends StatelessWidget {
  const GameCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCardCubit, GameCardState>(
      builder: (context, state) {
        if (state is GameCardOpened) {
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // '${game.teams.away.team} ${game.teams.away.mascot} vs ${game.teams.home.team} ${game.teams.home.mascot}',
                        '${state.game.teams.away.mascot} vs ${state.game.teams.home.mascot}',
                        style: Styles.h2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('EEEE, MMMM, c, y @ hh:mm a').format(
                              state.game.schedule.date.toLocal(),
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
                                  '${state.game.teams.away.mascot}',
                                  style: Styles.awayTeam,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              _betButtonSeparator(text: '@', style: Styles.h1),
                              Expanded(
                                child: Text(
                                  '${state.game.teams.home.mascot}',
                                  style: Styles.homeTeam,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              BetButton(
                                currentButtonPosition: 0,
                                text:
                                    '${state.game.odds[0].moneyline.current.awayOdds}',
                                game: state.game,
                                currentButton: state.betListNumber.elementAt(0),
                              ),
                              _betButtonSeparator(text: 'ML'),
                              BetButton(
                                currentButtonPosition: 1,
                                currentButton: state.betListNumber.elementAt(1),
                                game: state.game,
                                text:
                                    '${state.game.odds[0].moneyline.current.homeOdds}',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              BetButton(
                                currentButtonPosition: 2,
                                currentButton: state.betListNumber.elementAt(2),
                                game: state.game,
                                text:
                                    '${state.game.odds[0].spread.current.away}     ${state.game.odds[0].spread.current.awayOdds}',
                              ),
                              _betButtonSeparator(text: 'PTS'),
                              BetButton(
                                currentButtonPosition: 3,
                                currentButton: state.betListNumber.elementAt(3),
                                game: state.game,
                                text:
                                    '${state.game.odds[0].spread.current.home}     ${state.game.odds[0].spread.current.homeOdds}',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              BetButton(
                                currentButtonPosition: 4,
                                currentButton: state.betListNumber.elementAt(4),
                                game: state.game,
                                text:
                                    'o${state.game.odds[0].total.current.total}     ${state.game.odds[0].total.current.overOdds}',
                              ),
                              _betButtonSeparator(text: 'TOT'),
                              BetButton(
                                currentButtonPosition: 5,
                                currentButton: state.betListNumber.elementAt(5),
                                game: state.game,
                                text:
                                    'u${state.game.odds[0].total.current.total}     ${state.game.odds[0].total.current.underOdds}',
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
        } else {
          return Container();
        }
      },
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
