part of 'bet_slip_cubit.dart';

abstract class BetSlipState {
  const BetSlipState();
}

class BetSlipInitial extends BetSlipState {}

class BetSlipOpened extends BetSlipState {
  BetSlipOpened({
    @required this.games,
  });
  final List<Widget> games;
}
