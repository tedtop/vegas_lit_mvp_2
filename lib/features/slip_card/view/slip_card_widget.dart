import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/features/slip/bet_slip.dart';
import 'package:vegas_lit/features/wager_button/cubit/bet_button_cubit.dart';

import '../cubit/bet_slip_card_cubit.dart';
import 'slip_card_intertitial.dart';

class BetSlipCard extends StatefulWidget {
  BetSlipCard._({Key key}) : super(key: key);

  static Builder route({
    @required Key key,
    @required BetButtonCubit betButtonCubit,
  }) {
    return Builder(
      key: key,
      builder: (context) {
        return BlocProvider<BetSlipCardCubit>(
          create: (_) => BetSlipCardCubit()..openBetSlipCard(),
          child: BlocProvider.value(
            value: betButtonCubit,
            child: BetSlipCard._(),
          ),
        );
      },
    );
  }

  @override
  _BetSlipCardState createState() => _BetSlipCardState();
}

class _BetSlipCardState extends State<BetSlipCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BetSlipCardCubit, BetSlipCardState>(
      listener: (context, state) {
        if (state.status == BetSlipCardStatus.confirmed) {
          Navigator.of(context).push<void>(
            Interstitial.route(),
          );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case BetSlipCardStatus.opened:
            return BetSlipCardView();
            break;
          case BetSlipCardStatus.confirmed:
            return BetSlipCardView();
            break;
          default:
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }
}

// ignore: must_be_immutable
class BetSlipCardView extends StatefulWidget {
  @override
  _BetSlipCardViewState createState() => _BetSlipCardViewState();
}

class _BetSlipCardViewState extends State<BetSlipCardView> {
  final _formKey = GlobalKey<FormState>();

  final _betAmountController = TextEditingController(text: '10');
  final _focusNode = FocusNode();

  int toWinAmount = 100;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {
        if (_focusNode.hasFocus) {
          _betAmountController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _betAmountController.text.length,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;
    final betSlipCardState = context.watch<BetSlipCardCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 4.0,
      ),
      child: Card(
        color: Palette.lightGrey,
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${betButtonState.game.teams.away.mascot} @ ',
                        style: Styles.h2,
                      ),
                      TextSpan(
                        text: '${betButtonState.game.teams.home.mascot}',
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
                        betButtonState.game.schedule.date.toLocal(),
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
                            '${betButtonState.game.teams.away.mascot}',
                            style: Styles.awayTeam,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        _betButtonSeparator(text: '@', style: Styles.h1),
                        Expanded(
                          child: Text(
                            '${betButtonState.game.teams.home.mascot}',
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
                      child: Container(
                        color: Palette.green,
                        padding: const EdgeInsets.all(8.0),
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'BET BEARS TO WIN',
                              style: Styles.h3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text(
                                betButtonState.text,
                                style: Styles.h3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: betSlipCardState.status == BetSlipCardStatus.opened
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Form(
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
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _betAmountController,
                                                    focusNode: _focusNode,
                                                    onChanged: (text) {
                                                      setState(
                                                        () {
                                                          toWinAmount = (100 /
                                                                  int.parse(
                                                                      betButtonState
                                                                          .text) *
                                                                  int.parse(
                                                                      text))
                                                              .toInt();
                                                        },
                                                      );
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    maxLengthEnforcement:
                                                        MaxLengthEnforcement
                                                            .enforced,
                                                    maxLength: 3,
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
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 140,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: betSlipCardState.status ==
                                                  BetSlipCardStatus.confirmed
                                              ? const Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'BET PLACED',
                                                    ),
                                                  ),
                                                )
                                              : RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
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
                                                      context
                                                          .read<
                                                              BetButtonCubit>()
                                                          .confirmBetButton();
                                                      context
                                                          .read<
                                                              BetSlipCardCubit>()
                                                          .betSlipCardConfirm(
                                                            betAmount:
                                                                _betAmountController
                                                                    .text,
                                                          );
                                                    }
                                                  },
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Palette.darkGrey,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        height: 100,
                                        width: 140,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'To Win',
                                                style: TextStyle(
                                                    color: Palette.white,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                '\$$toWinAmount',
                                                style: const TextStyle(
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
                                        child: betSlipCardState.status ==
                                                BetSlipCardStatus.confirmed
                                            ? Container()
                                            : RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
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
                                                      .read<BetButtonCubit>()
                                                      .unclickBetButton();
                                                  context
                                                      .read<BetSlipCubit>()
                                                      .removeBetSlip(
                                                        uniqueId: betButtonState
                                                            .uniqueId,
                                                      );
                                                },
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                'BET PLACED OF \$${betSlipCardState.betAmount}',
                              ),
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
