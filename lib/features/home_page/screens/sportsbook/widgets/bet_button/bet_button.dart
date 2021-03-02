import 'package:flutter/material.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/home_page/screens/bet_slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/home_page/screens/bet_slip/widgets/slip_card/slip_card.dart';

import 'cubit/bet_button_cubit.dart';

class BetButton extends StatefulWidget {
  const BetButton._({Key key}) : super(key: key);

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
          child: const BetButton._(),
        );
      },
    );
  }

  @override
  _BetButtonState createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButton> {
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
        padding: const EdgeInsets.all(5.0),
        child: RaisedButton(
          padding: const EdgeInsets.all(8.0),
          elevation: Styles.elevation,
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
        padding: const EdgeInsets.all(5.0),
        child: RaisedButton(
          padding: const EdgeInsets.all(8.0),
          elevation: Styles.elevation,
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
