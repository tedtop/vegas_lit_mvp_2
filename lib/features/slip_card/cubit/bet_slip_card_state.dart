part of 'bet_slip_card_cubit.dart';

abstract class BetSlipCardState {
  const BetSlipCardState();
}

class BetSlipCardInitial extends BetSlipCardState {}

class BetSlipCardOpened extends BetSlipCardState {
  BetSlipCardOpened({
    @required this.game,
    @required this.cubit,
    @required this.uniqueId,
    @required this.currentPositionNumber,
    @required this.text,
  });

  final Game game;
  final GameCardCubit cubit;
  final String uniqueId;
  final int currentPositionNumber;
  final String text;
}

class BetSlipCardConfirmed extends BetSlipCardState {
  BetSlipCardConfirmed({
    @required this.game,
    @required this.cubit,
    @required this.uniqueId,
    @required this.currentPositionNumber,
    @required this.text,
  });

  final Game game;
  final GameCardCubit cubit;
  final String uniqueId;
  final int currentPositionNumber;
  final String text;
}

class BetSlipCardError extends BetSlipCardState {}
