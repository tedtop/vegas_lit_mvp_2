import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      yield* _mapSportsBookOpenToState();
    }
  }

  Stream<SportsbookState> _mapSportsBookOpenToState() async* {
    final games = await Game.fetchAllFromMock();
    yield SportsbookOpened(games: games);
  }
}
