import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';

import '../../constants/palette.dart';
import '../../constants/styles.dart';

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
            return BetSlipList(
              games: state.betSlipGames,
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class BetSlipList extends StatelessWidget {
  const BetSlipList({Key key, this.games}) : super(key: key);

  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key('${games.length}'),
      itemCount: games.length,
      itemBuilder: (context, index) {
        return BetSlipCard(
          game: games[index],
        );
      },
    );
  }
}

class BetSlipCard extends StatelessWidget {
  const BetSlipCard({Key key, @required Game game})
      : assert(game != null),
        _game = game,
        super(key: key);

  final Game _game;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportsbookBloc, SportsbookState>(
      builder: (context, state) {
        if (state is SportsbookOpened) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 4.0,
            ),
            child: Card(
              elevation: Styles.elevation,
              color: Palette.darkGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        // '${game.teams.away.team} ${game.teams.away.mascot} vs ${game.teams.home.team} ${game.teams.home.mascot}',
                        '${_game.teams.away.mascot} vs ${_game.teams.home.mascot}',
                        style: Styles.h2,
                      ),
                      const Text(
                        'Starts in 20h 20m 20s',
                        style: TextStyle(
                          color: Palette.red,
                        ),
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.all(
                          10.0,
                        ),
                        color: Palette.green,
                        child: const Text('BET BEARS TO WIN'),
                        onPressed: () {
                          print('Bet clicked');
                        },
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.all(
                          10.0,
                        ),
                        color: Colors.red,
                        child: const Text('Remove'),
                        onPressed: () {
                          context.read<SportsbookBloc>().add(
                                SportsbookOpen(
                                  betSlipGames: state.betSlipGames
                                    ..remove(_game),
                                ),
                              );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
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
