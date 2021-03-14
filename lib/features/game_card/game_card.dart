import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/palette.dart';

import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/wager_button/wager_button.dart';

import '../widgets/generic_card.dart';
import 'cubit/game_card_cubit.dart';

class GameCard extends StatelessWidget {
  const GameCard._({Key key}) : super(key: key);

  static Builder route({@required Game game}) {
    return Builder(
      builder: (_) {
        return BlocProvider(
          create: (context) => GameCardCubit()
            ..openGameCard(
              game: game,
            ),
          child: const GameCard._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCardCubit, GameCardState>(
      builder: (context, state) {
        if (state is GameCardOpened) {
          return GenericCard(
            widgets: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: state.game.teams.away.mascot.toUpperCase(),
                    ),
                    const TextSpan(text: '  @  '),
                    TextSpan(
                      text: state.game.teams.home.mascot.toUpperCase(),
                      style: GoogleFonts.nunito(color: Palette.green),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      DateFormat('EEEE, MMMM, c, y @ hh:mm a').format(
                        state.game.schedule.date.toLocal(),
                      ),
                      style: GoogleFonts.nunito(
                        color: Palette.cream,
                        fontSize: 12,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Starting in',
                            style: GoogleFonts.nunito(
                              color: Palette.cream,
                              fontSize: 10,
                            ),
                          ),
                          TextSpan(
                            text: '20hr:17m:18s',
                            style: GoogleFonts.nunito(
                              color: Palette.red,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  state.game.odds == null
                      ? Container()
                      : Row(
                          children: [
                            WagerButton.route(
                              text:
                                  '${state.game.odds[0].moneyline.current.awayOdds}',
                              game: state.game,
                            ),
                            _betButtonSeparator(text: 'ML'),
                            WagerButton.route(
                              game: state.game,
                              text:
                                  '${state.game.odds[0].moneyline.current.homeOdds}',
                            ),
                          ],
                        ),
                  state.game.odds == null
                      ? Container()
                      : Row(
                          children: [
                            WagerButton.route(
                              game: state.game,
                              text:
                                  '${state.game.odds[0].spread.current.away}     ${state.game.odds[0].spread.current.awayOdds}',
                            ),
                            _betButtonSeparator(text: 'PTS'),
                            WagerButton.route(
                              game: state.game,
                              text:
                                  '${state.game.odds[0].spread.current.home}     ${state.game.odds[0].spread.current.homeOdds}',
                            ),
                          ],
                        ),
                  state.game.odds == null
                      ? Container()
                      : Row(
                          children: [
                            WagerButton.route(
                              game: state.game,
                              text:
                                  'o${state.game.odds[0].total.current.total}     ${state.game.odds[0].total.current.overOdds}',
                            ),
                            _betButtonSeparator(text: 'TOT'),
                            WagerButton.route(
                              game: state.game,
                              text:
                                  'u${state.game.odds[0].total.current.total}     ${state.game.odds[0].total.current.underOdds}',
                            ),
                          ],
                        ),
                ],
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _betButtonSeparator({
    String text,
  }) {
    return SizedBox(
      width: 40,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color: Palette.cream,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
