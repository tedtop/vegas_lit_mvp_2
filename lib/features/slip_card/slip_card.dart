import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/bet_slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/game_card/cubit/game_card_cubit.dart';

class BetSlipCard extends StatelessWidget {
  const BetSlipCard({
    Key key,
    @required Game game,
    @required GameCardCubit cubit,
    @required String uniqueId,
    @required int currentPositionNumber,
  })  : assert(game != null),
        assert(cubit != null),
        assert(uniqueId != null),
        assert(currentPositionNumber != null),
        _game = game,
        _cubit = cubit,
        _uniqueId = uniqueId,
        _currentPositionNumber = currentPositionNumber,
        super(key: key);

  final Game _game;
  final GameCardCubit _cubit;
  final String _uniqueId;
  final int _currentPositionNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<BetSlipCubit, BetSlipState>(
        builder: (context, state) {
          final gameCardCubit = context.watch<GameCardCubit>().state;
          if (state is BetSlipOpened) {
            if (gameCardCubit is GameCardOpened) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 4.0,
                ),
                child: Card(
                  elevation: Styles.elevation,
                  color: Palette.lightGrey,
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
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${_game.teams.away.mascot} @ ',
                                  style: Styles.h2,
                                ),
                                TextSpan(
                                  text: '${_game.teams.home.mascot}',
                                  style: GoogleFonts.nunito(
                                    color: Palette.red,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${_game.teams.away.mascot}',
                                      style: Styles.awayTeam,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  _betButtonSeparator(
                                      text: '@', style: Styles.h1),
                                  Expanded(
                                    child: Text(
                                      '${_game.teams.home.mascot}',
                                      style: Styles.homeTeam,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Palette.darkGrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          height: 80,
                                          width: 140,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'BET AMOUNT',
                                                  style: TextStyle(
                                                      color: Palette.white,
                                                      fontSize: 15),
                                                ),
                                                const Text(
                                                  '\$100.0',
                                                  style: TextStyle(
                                                    color: Palette.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 140,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: RaisedButton(
                                            padding: const EdgeInsets.all(
                                              10.0,
                                            ),
                                            color: Palette.green,
                                            child: Text(
                                              'PLACE BET',
                                              style: Styles.h3,
                                            ),
                                            onPressed: () {
                                              print('Bet Placed');
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Palette.darkGrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          height: 80,
                                          width: 140,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'To Win',
                                                  style: TextStyle(
                                                      color: Palette.white,
                                                      fontSize: 15),
                                                ),
                                                const Text(
                                                  '\$100.0',
                                                  style: TextStyle(
                                                    color: Palette.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 140,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: RaisedButton(
                                            padding: const EdgeInsets.all(
                                              10.0,
                                            ),
                                            color: Palette.red,
                                            child: Text(
                                              'CANCEL',
                                              style: TextStyle(
                                                color: Palette.white,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<BetSlipCubit>()
                                                  .openBetSlip(
                                                    betSlipGames: state.games
                                                      ..removeWhere(
                                                        (element) =>
                                                            element.key ==
                                                            Key('$_uniqueId'),
                                                      ),
                                                  );
                                              final newList =
                                                  gameCardCubit.betListNumber;
                                              newList[_currentPositionNumber] =
                                                  false;
                                              context.read<GameCardCubit>()
                                                ..openGameCard(
                                                  betListNumber: newList,
                                                  game: _game,
                                                );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
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
            } else {
              return Container();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
