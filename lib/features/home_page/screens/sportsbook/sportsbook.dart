import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:vegas_lit/data/models/game.dart';

import 'bloc/sportsbook_bloc.dart';
import 'widgets/game_card/game_card.dart';
import 'widgets/home_interstitial.dart';

class Sportsbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportsbookBloc, SportsbookState>(
      listener: (context, state) {
        if (state is SportsbookOpened) {
          Navigator.of(context).push<void>(
            Interstitial.route(),
          );
        }
      },
      builder: (context, state) {
        if (state is SportsbookOpened) {
          return SportsBookView(
            games: state.games,
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

class SportsBookView extends StatelessWidget {
  const SportsBookView({
    Key key,
    @required this.games,
  })  : assert(games != null),
        super(key: key);

  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NFL Games (13 Games)',
                    style: Styles.h3,
                  ),
                  const Icon(Icons.download_rounded)
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: games.length,
            itemBuilder: (context, index) {
              return GameCard.route(
                game: games[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
