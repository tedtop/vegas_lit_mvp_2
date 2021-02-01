import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/bet_slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/game_card/cubit/game_card_cubit.dart';
import 'package:vegas_lit/features/slip_card/slip_card.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';

class BetButton extends StatefulWidget {
  const BetButton({
    Key key,
    @required this.text,
    @required this.game,
    @required this.currentButton,
    @required this.currentButtonPosition,
  }) : super(key: key);

  final String text;
  final Game game;
  final bool currentButton;
  final int currentButtonPosition;

  @override
  _BetButtonState createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButton> {
  final uniqueId = Uuid().v1();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetSlipCubit, BetSlipState>(
      builder: (context, state) {
        if (state is BetSlipOpened) {
          final gameCardCubit = context.watch<GameCardCubit>().state;
          if (gameCardCubit is GameCardOpened) {
            return Expanded(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: RaisedButton(
                  padding: const EdgeInsets.all(10.0),
                  elevation: Styles.elevation,
                  color:
                      widget.currentButton ? Palette.green : Palette.lightGrey,
                  child: Text(
                    widget.text,
                    style: widget.currentButton
                        ? Styles.betBtnTextSelected
                        : Styles.betBtnText,
                  ),
                  onPressed: () {
                    if (widget.currentButton == false) {
                      context.read<BetSlipCubit>().openBetSlip(
                            betSlipGames: state.games
                              ..add(
                                BetSlipCard(
                                  key: Key('$uniqueId'),
                                  game: widget.game,
                                  cubit: context.read<GameCardCubit>(),
                                  currentPositionNumber:
                                      widget.currentButtonPosition,
                                  uniqueId: uniqueId,
                                ),
                              ),
                          );
                      final newList = gameCardCubit.betListNumber;
                      newList[widget.currentButtonPosition] = true;
                      context.read<GameCardCubit>()
                        ..openGameCard(
                          betListNumber: newList,
                          game: widget.game,
                        );
                    } else {
                      context.read<BetSlipCubit>().openBetSlip(
                            betSlipGames: state.games
                              ..removeWhere(
                                (element) => element.key == Key('$uniqueId'),
                              ),
                          );
                      final newList = gameCardCubit.betListNumber;
                      newList[widget.currentButtonPosition] = false;
                      context.read<GameCardCubit>()
                        ..openGameCard(
                          betListNumber: newList,
                          game: widget.game,
                        );
                    }
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
