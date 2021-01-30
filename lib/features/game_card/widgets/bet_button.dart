import 'package:flutter/material.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';

class BetButton extends StatefulWidget {
  final String text;
  final Game game;

  const BetButton({Key key, @required this.text, @required this.game})
      : super(key: key);
  @override
  _BetButtonState createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportsbookBloc, SportsbookState>(
      builder: (context, state) {
        if (state is SportsbookOpened) {
          return Expanded(
            child: Container(
              // Padding around BetButton(s)
              padding: const EdgeInsets.all(5.0),
              // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: RaisedButton(
                // Padding inside BetButton(s)
                padding: const EdgeInsets.all(10.0),
                elevation: Styles.elevation,
                color: isSelected ? Palette.green : Palette.lightGrey,
                child: Text(
                  widget.text,
                  style: isSelected
                      ? Styles.betBtnTextSelected
                      : Styles.betBtnText,
                ),
                onPressed: () {
                  if (isSelected == false) {
                    context.read<SportsbookBloc>().add(
                          SportsbookOpen(
                            betSlipGames: state.betSlipGames..add(widget.game),
                          ),
                        );
                  } else {
                    context.read<SportsbookBloc>().add(
                          SportsbookOpen(
                            betSlipGames: state.betSlipGames
                              ..remove(widget.game),
                          ),
                        );
                  }
                  setState(
                    () => isSelected = !isSelected,
                  );
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
