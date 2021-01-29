import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/game.dart';

part 'bet_slip_event.dart';
part 'bet_slip_state.dart';

class BetSlipBloc extends Bloc<BetSlipEvent, BetSlipState> {
  BetSlipBloc() : super(BetSlipInitial());

  @override
  Stream<BetSlipState> mapEventToState(
    BetSlipEvent event,
  ) async* {
    if (event is BetSlipUpdate) {
      yield BetSlipUpdated(event.game);
    }
  }
}
