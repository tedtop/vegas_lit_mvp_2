import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/game_card/cubit/game_card_cubit.dart';

part 'bet_slip_card_state.dart';

class BetSlipCardCubit extends Cubit<BetSlipCardState> {
  BetSlipCardCubit()
      : super(
          BetSlipCardInitial(),
        );

  void openBetSlipCard({
    @required Game game,
    @required GameCardCubit cubit,
    @required String uniqueId,
    @required int currentPositionNumber,
    @required String text,
  }) {
    emit(
      BetSlipCardOpened(
        game: game,
        cubit: cubit,
        uniqueId: uniqueId,
        currentPositionNumber: currentPositionNumber,
        text: text,
      ),
    );
  }

  void betSlipCardConfirm({
    @required Game game,
    @required GameCardCubit cubit,
    @required String uniqueId,
    @required int currentPositionNumber,
    @required String text,
  }) {
    emit(
      BetSlipCardConfirmed(
        game: game,
        cubit: cubit,
        uniqueId: uniqueId,
        currentPositionNumber: currentPositionNumber,
        text: text,
      ),
    );
  }
}
