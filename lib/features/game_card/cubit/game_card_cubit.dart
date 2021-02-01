import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/game.dart';

part 'game_card_state.dart';

class GameCardCubit extends Cubit<GameCardState> {
  GameCardCubit() : super(GameCardInitial());

  void openGameCard({
    @required List<bool> betListNumber,
    @required Game game,
  }) async {
    emit(
      GameCardOpened(game: game, betListNumber: betListNumber),
    );
  }
}