part of 'bet_slip_bloc.dart';

abstract class BetSlipState extends Equatable {
  const BetSlipState();

  @override
  List<Object> get props => [];
}

class BetSlipInitial extends BetSlipState {}

class BetSlipUpdated extends BetSlipState {
  final Game game;

  BetSlipUpdated(this.game);
}
