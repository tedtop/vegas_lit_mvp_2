import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';

import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/bet_button/bet_button.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        state.game.teams.away.mascot.toUpperCase(),
                        maxLines: 1,
                        style: Styles.defaultSizeBoldCream,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '@',
                        style: Styles.defaultSizeBoldCream,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        state.game.teams.home.mascot.toUpperCase(),
                        maxLines: 1,
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.green,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EEEE, MMMM, c, y @ hh:mm a').format(
                        state.game.schedule.date.toLocal(),
                      ),
                      style: Styles.smallSizeColorCream,
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: 'Starting in',
                    //         style: Styles.moreSmallSizeColorCream,
                    //       ),
                    //       TextSpan(
                    //         text: '20hr:17m:18s',
                    //         style: Styles.moreSmallSizeColorRed,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Column(
                children: [
                  state.game.odds == null
                      ? Container()
                      : Row(
                          children: [
                            BetButton.route(
                              betType: Bet.ml,
                              text:
                                  '${state.game.odds[0].moneyline.current.awayOdds}',
                              game: state.game,
                            ),
                            _betButtonSeparator(text: 'ML'),
                            BetButton.route(
                              betType: Bet.ml,
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
                            BetButton.route(
                              betType: Bet.pts,
                              game: state.game,
                              text:
                                  '${state.game.odds[0].spread.current.away}     ${state.game.odds[0].spread.current.awayOdds}',
                            ),
                            _betButtonSeparator(text: 'PTS'),
                            BetButton.route(
                              betType: Bet.pts,
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
                            BetButton.route(
                              betType: Bet.tot,
                              game: state.game,
                              text:
                                  'o${state.game.odds[0].total.current.total}     ${state.game.odds[0].total.current.overOdds}',
                            ),
                            _betButtonSeparator(text: 'TOT'),
                            BetButton.route(
                              betType: Bet.tot,
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
      child: AutoSizeText(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: Styles.defaultSizeColorCreamBold,
      ),
    );
  }
}
