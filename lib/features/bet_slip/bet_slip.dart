import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:vegas_lit/features/bet_slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/slip_card/slip_card.dart';

class BetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetSlipCubit, BetSlipState>(
      builder: (context, state) {
        if (state is BetSlipOpened) {
          if (state.games.isEmpty) {
            return Column(
              children: [
                BetSlipUpper(),
                EmptyBetSlip(),
              ],
            );
          } else {
            return Column(
              children: [
                BetSlipUpper(),
                Expanded(
                  child: ListView(
                    key: Key('${state.games.length}'),
                    shrinkWrap: true,
                    children: state.games,
                  ),
                ),
              ],
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
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
            betSlipState is BetSlipOpened
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
                : Container()
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
          textPoints('1. Find a game you are interested in'),
          textPoints('2. Click on the link you\'d like to bet on'),
          textPoints(
              '3. Your bet will show up in this area where you can \nplace your bet'),
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
