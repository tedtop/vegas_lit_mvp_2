import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/slip/bet_slip.dart';
import 'package:vegas_lit/features/slip_card/view/slip_card_widget.dart';

import '../cubit/bet_button_cubit.dart';

class WagerButton extends StatelessWidget {
  const WagerButton._({Key key}) : super(key: key);

  static Builder route({
    @required String text,
    @required Game game,
  }) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (_) => BetButtonCubit()
            ..openBetButton(
              text: text,
              game: game,
            ),
          child: const WagerButton._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final betButtonState = context.watch<BetButtonCubit>().state;
        switch (betButtonState.status) {
          case BetButtonStatus.unclicked:
            return BetButtonUnclicked();
            break;
          case BetButtonStatus.clicked:
            return BetButtonClicked();
            break;
          case BetButtonStatus.done:
            return BetButtonDone();
            break;
          default:
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }
}

class BetButtonUnclicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(8.0),
          color: Palette.lightGrey,
          child: Text(
            betButtonState.text,
            style: Styles.betBtnText,
          ),
          onPressed: () {
            context.read<BetButtonCubit>().clickBetButton();
            context.read<BetSlipCubit>().addBetSlip(
                  game: BetSlipCard.route(
                    key: Key('${betButtonState.uniqueId}'),
                    betButtonCubit: context.read<BetButtonCubit>(),
                  ),
                );
          },
        ),
      ),
    );
  }
}

class BetButtonClicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(8.0),
          color: Palette.green,
          child: Text(
            betButtonState.text,
            style: Styles.betBtnTextSelected,
          ),
          onPressed: () {
            context.read<BetButtonCubit>().unclickBetButton();
            context.read<BetSlipCubit>().removeBetSlip(
                  uniqueId: betButtonState.uniqueId,
                );
          },
        ),
      ),
    );
  }
}

class BetButtonDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Icon(Icons.thumb_up),
      ),
    );
  }
}
