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
      yield* _mapSportsbookOpenToState(event);
    }
  }

  Stream<SportsbookState> _mapSportsbookOpenToState(
      SportsbookOpen event) async* {
    final games = await Game.fetchAllFromMock();
    yield SportsbookOpened(
      games: games,
    );
  }
}
