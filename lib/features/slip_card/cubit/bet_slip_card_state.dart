part of 'bet_slip_card_cubit.dart';

abstract class BetSlipCardState extends Equatable {
  const BetSlipCardState();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [
        game,
        cubit,
        uniqueId,
        currentPositionNumber,
        text,
      ];
}

class BetSlipCardError extends BetSlipCardState {}
