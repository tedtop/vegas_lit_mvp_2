import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:vegas_lit/data/models/game.dart';

part 'bet_button_state.dart';

class BetButtonCubit extends Cubit<BetButtonState> {
  BetButtonCubit()
      : super(
          const BetButtonState.loading(),
        );

  void openBetButton({
    @required String text,
    @required Game game,
  }) {
    final uniqueId = Uuid().v1();
    emit(
      BetButtonState.unclicked(
        text: text,
        game: game,
        uniqueId: uniqueId,
      ),
    );
  }

  void clickBetButton() {
    emit(
      BetButtonState.clicked(
        text: state.text,
        game: state.game,
        uniqueId: state.uniqueId,
      ),
    );
  }

  void unclickBetButton() {
    emit(
      BetButtonState.unclicked(
        text: state.text,
        game: state.game,
        uniqueId: state.uniqueId,
      ),
    );
  }

  void confirmBetButton() {
    emit(
      BetButtonState.done(
        text: state.text,
        game: state.game,
        uniqueId: state.uniqueId,
      ),
    );
  }
}
