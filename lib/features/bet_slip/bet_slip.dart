import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/slip_card/slip_card.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';

class BetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportsbookBloc, SportsbookState>(
      builder: (context, state) {
        if (state is SportsbookOpened) {
          if (state.betSlipGames.isEmpty) {
            return const Center(
              child: Text('Your Bet List is currently Empty'),
            );
          } else {
            return ListView.builder(
              key: Key('${state.betSlipGames.length}'),
              itemCount: state.betSlipGames.length,
              itemBuilder: (context, index) {
                return BetSlipCard(
                  game: state.betSlipGames[index],
                );
              },
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
