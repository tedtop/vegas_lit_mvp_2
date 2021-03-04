import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

import 'cubit/bet_slip_cubit.dart';

class BetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BetSlipUpper(),
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              // case BetSlipStatus.empty:
              //   return EmptyBetSlip();
              //   break;
              case BetSlipStatus.opened:
                return state.games.isEmpty ? EmptyBetSlip() : BetSlipList();
                break;
              default:
                return const CircularProgressIndicator();
                break;
            }
          },
        ),
      ],
    );
  }
}

class BetSlipUpper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betSlipState = context.watch<BetSlipCubit>().state;
    return Container(
      height: 40,
      color: Palette.green,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('BET SLIP'),
            betSlipState.status == BetSlipStatus.opened
                ? Container(
                    height: 20,
                    width: 20,
                    color: Palette.darkGrey,
                    child: Center(
                      child: Text(
                        betSlipState.games.length.toString(),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class EmptyBetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Bet List is\ncurrently Empty.',
            style: Styles.h2,
          ),
          const SizedBox(
            height: 20,
          ),
          textPoints(
            '1. Find a game you are interested in',
          ),
          textPoints(
            '2. Click on the link you\'d like to bet on',
          ),
          textPoints(
            // ignore: lines_longer_than_80_chars
            '3. Your bet will show up in this area where you can \nplace your bet',
          ),
        ],
      ),
    );
  }

  Widget textPoints(String text) {
    return Column(
      children: [
        Text(
          text,
          style: Styles.emptySlipText,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class BetSlipList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 10;
    final betSlipState = context.watch<BetSlipCubit>().state;
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: kIsWeb ? width / 2 : 0,
        ),
        key: Key('${betSlipState.games.length}'),
        shrinkWrap: true,
        children: betSlipState.games,
      ),
    );
  }
}
