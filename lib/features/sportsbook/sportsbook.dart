import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';
import 'package:vegas_lit/features/game_card/game_card.dart';

class Sportsbook extends StatefulWidget {
  @override
  _SportsbookState createState() => _SportsbookState();
}

class _SportsbookState extends State<Sportsbook>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SportsbookBloc, SportsbookState>(
      builder: (context, state) {
        if (state is SportsbookOpened) {
          return ListView.builder(
            itemCount: state.games.length,
            itemBuilder: (context, index) {
              return GameCard(
                game: state.games[index],
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
