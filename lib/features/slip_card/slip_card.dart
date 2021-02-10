import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/bet_slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/game_card/cubit/game_card_cubit.dart';
import 'package:vegas_lit/features/slip_card/cubit/bet_slip_card_cubit.dart';
import 'package:vegas_lit/features/slip_card/widgets/interstitial.dart';

class BetSlipCard extends StatelessWidget {
  BetSlipCard._({Key key}) : super(key: key);

  static BlocProvider route({
    @required Key key,
    @required Game game,
    @required GameCardCubit cubit,
    @required String uniqueId,
    @required int currentPositionNumber,
    @required String text,
  }) {
    return BlocProvider<BetSlipCardCubit>(
      key: key,
      lazy: true,
      create: (_) => BetSlipCardCubit()
        ..openBetSlipCard(
          game: game,
          cubit: cubit,
          uniqueId: uniqueId,
          currentPositionNumber: currentPositionNumber,
          text: text,
        ),
      child: BetSlipCard._(),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetSlipCardCubit, BetSlipCardState>(
      builder: (context, betSlipCardState) {
        if (betSlipCardState is BetSlipCardOpened) {
          return BlocProvider.value(
            value: betSlipCardState.cubit,
            child: BlocBuilder<BetSlipCubit, BetSlipState>(
              builder: (context, betSlipState) {
                if (betSlipState is BetSlipOpened) {
                  return BlocBuilder<GameCardCubit, GameCardState>(
                    builder: (context, gameCardState) {
                      if (gameCardState is GameCardOpened) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                '${betSlipCardState.game.teams.away.mascot} @ ',
                                            style: Styles.h2,
                                          ),
                                          TextSpan(
                                            text:
                                                '${betSlipCardState.game.teams.home.mascot}',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat(
                                                  'EEEE, MMMM, c, y @ hh:mm a')
                                              .format(
                                            betSlipCardState.game.schedule.date
                                                .toLocal(),
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
                                                '${betSlipCardState.game.teams.away.mascot}',
                                                style: Styles.awayTeam,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            _betButtonSeparator(
                                                text: '@', style: Styles.h1),
                                            Expanded(
                                              child: Text(
                                                '${betSlipCardState.game.teams.home.mascot}',
                                                style: Styles.homeTeam,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 8.0,
                                          child: Container(
                                            color: Palette.green,
                                            padding: const EdgeInsets.all(8.0),
                                            height: 40,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'BET BEARS TO WIN',
                                                  style: Styles.h3,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 40),
                                                  child: Text(
                                                    betSlipCardState.text,
                                                    style: Styles.h3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Palette.darkGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      height: 100,
                                                      width: 140,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              'BET AMOUNT',
                                                              style: TextStyle(
                                                                  color: Palette
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLengthEnforced:
                                                                    true,
                                                                maxLength: 3,
                                                                initialValue:
                                                                    '10',
                                                                decoration:
                                                                    const InputDecoration(
                                                                  counterText:
                                                                      '',
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return 'Empty Box';
                                                                  }
                                                                  if (int.parse(
                                                                          value) >=
                                                                      101) {
                                                                    return '100\$ Limit Reached';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            // const Text(
                                                            //   '\$100.0',
                                                            //   style: TextStyle(
                                                            //     color: Palette.white,
                                                            //     fontSize: 15,
                                                            //     fontWeight: FontWeight.w800,
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 140,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: RaisedButton(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(
                                                          10.0,
                                                        ),
                                                        color: Palette.green,
                                                        child: Text(
                                                          'PLACE BET',
                                                          style: Styles.h3,
                                                        ),
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState
                                                              .validate()) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return Interstitial();
                                                                },
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
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
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    height: 100,
                                                    width: 140,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'To Win',
                                                            style: TextStyle(
                                                                color: Palette
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                          const Text(
                                                            '\$100.0',
                                                            style: TextStyle(
                                                              color:
                                                                  Palette.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
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
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: RaisedButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10.0,
                                                      ),
                                                      color: Palette.red,
                                                      child: const Text(
                                                        'CANCEL',
                                                        style: TextStyle(
                                                          color: Palette.white,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                BetSlipCubit>()
                                                            .openBetSlip(
                                                              betSlipGames:
                                                                  betSlipState
                                                                      .games
                                                                    ..removeWhere(
                                                                      (element) =>
                                                                          element
                                                                              .key ==
                                                                          Key('${betSlipCardState.uniqueId}'),
                                                                    ),
                                                            );
                                                        final newList =
                                                            gameCardState
                                                                .betListNumber;
                                                        newList[betSlipCardState
                                                                .currentPositionNumber] =
                                                            false;
                                                        context.read<
                                                            GameCardCubit>()
                                                          ..openGameCard(
                                                            betListNumber:
                                                                newList,
                                                            game:
                                                                betSlipCardState
                                                                    .game,
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
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        } else {
          return const Text('Some Error Occurred');
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
