import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/bet_slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/game_card/cubit/game_card_cubit.dart';
import 'package:vegas_lit/features/slip_card/widgets/interstitial.dart';

class BetSlipCard extends StatelessWidget {
  BetSlipCard({
    Key key,
    @required Game game,
    @required GameCardCubit cubit,
    @required String uniqueId,
    @required int currentPositionNumber,
    @required String text,
  })  : assert(game != null),
        assert(cubit != null),
        assert(uniqueId != null),
        assert(currentPositionNumber != null),
        assert(text != null),
        _game = game,
        _cubit = cubit,
        _uniqueId = uniqueId,
        _currentPositionNumber = currentPositionNumber,
        _text = text,
        super(key: key);

  final Game _game;
  final GameCardCubit _cubit;
  final String _uniqueId;
  final int _currentPositionNumber;
  final String _text;

  final _formKey = GlobalKey<FormState>();

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
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 8.0,
                                child: Container(
                                  color: Palette.green,
                                  padding: const EdgeInsets.all(8.0),
                                  height: 40,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'BET BEARS TO WIN',
                                        style: Styles.h3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40),
                                        child: Text(
                                          _text,
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
                                                  BorderRadius.circular(8),
                                            ),
                                            height: 100,
                                            width: 140,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
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
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLengthEnforced: true,
                                                      maxLength: 3,
                                                      initialValue: '10',
                                                      decoration:
                                                          const InputDecoration(
                                                        counterText: '',
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Empty Box';
                                                        }
                                                        if (int.parse(value) >=
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
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
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
                                                BorderRadius.circular(8),
                                          ),
                                          height: 100,
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
                                            child: const Text(
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
