import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/game.dart';

part 'sportsbook_event.dart';
part 'sportsbook_state.dart';

class SportsbookBloc extends Bloc<SportsbookEvent, SportsbookState> {
  SportsbookBloc()
      : super(
          SportsbookInitial(),
        );

  @override
  Stream<SportsbookState> mapEventToState(
    SportsbookEvent event,
  ) async* {
    if (event is SportsbookOpen) {
      yield* _mapSportsBookOpenToState(event);
    }
  }

  Stream<SportsbookState> _mapSportsBookOpenToState(
      SportsbookOpen event) async* {
    final games = await Game.fetchAllFromMock();
    final betSlipGames = <Game>[...event.betSlipGames];
    yield SportsbookOpened(
      games: games,
      betSlipGames: betSlipGames,
    );
  }
}
