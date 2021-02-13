import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bet_slip_card_state.dart';

class BetSlipCardCubit extends Cubit<BetSlipCardState> {
  BetSlipCardCubit()
      : super(
          const BetSlipCardState.loading(),
        );

  void openBetSlipCard() {
    emit(
      const BetSlipCardState.opened(),
    );
  }

  void betSlipCardConfirm({@required String betAmount}) {
    emit(
      BetSlipCardState.confirmed(betAmount: betAmount),
    );
  }
}
