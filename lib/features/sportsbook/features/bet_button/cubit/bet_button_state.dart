part of 'bet_button_cubit.dart';

enum BetButtonStatus { done, error, loading, clicked, unclicked }

class BetButtonState extends Equatable {
  const BetButtonState._({
    this.text,
    this.game,
    this.uniqueId,
    this.status = BetButtonStatus.loading,
  });

  const BetButtonState.loading() : this._();

  const BetButtonState.clicked({
    @required String text,
    @required Game game,
    @required String uniqueId,
  }) : this._(
          status: BetButtonStatus.clicked,
          text: text,
          game: game,
          uniqueId: uniqueId,
        );

  const BetButtonState.unclicked({
    @required String text,
    @required Game game,
    @required String uniqueId,
  }) : this._(
          status: BetButtonStatus.unclicked,
          text: text,
          game: game,
          uniqueId: uniqueId,
        );

  const BetButtonState.done({
    @required String text,
    @required Game game,
    @required String uniqueId,
  }) : this._(
          status: BetButtonStatus.done,
          text: text,
          game: game,
          uniqueId: uniqueId,
        );

  // const BetButtonState.error() : this._(status: BetButtonStatus.error);

  final BetButtonStatus status;
  final String text;
  final Game game;
  final String uniqueId;

  @override
  List<Object> get props => [
        status,
        text,
        game,
        uniqueId,
      ];
}
