import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'bet_slip_state.dart';

class BetSlipCubit extends Cubit<BetSlipState> {
  BetSlipCubit()
      : super(
          BetSlipInitial(),
        );

  void openBetSlip({@required List<Widget> betSlipGames}) async {
    emit(
      BetSlipOpened(games: betSlipGames),
    );
  }
}
