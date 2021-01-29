import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/bet_slip/widgets/bet_slip_card.dart';

import 'bloc/bet_slip_bloc.dart';

class BetSlip extends StatefulWidget {
  @override
  _BetSlipState createState() => _BetSlipState();
}

class _BetSlipState extends State<BetSlip> {
  final games = <Game>[];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetSlipBloc, BetSlipState>(
      builder: (context, state) {
        if (state is BetSlipInitial) {
          return const Center(
            child: Text('Your Bet List is currently Empty'),
          );
        }
        if (state is BetSlipUpdated) {
          games..add(state.game);
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              return BetSlipCard(
                game: games[index],
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
