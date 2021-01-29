part of 'bet_slip_bloc.dart';

abstract class BetSlipEvent extends Equatable {
  const BetSlipEvent();

  @override
  List<Object> get props => [];
}

class BetSlipUpdate extends BetSlipEvent {
  final Game game;

  BetSlipUpdate({@required this.game});
}
