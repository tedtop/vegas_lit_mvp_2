import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/slip_card/cubit/bet_slip_card_cubit.dart';

class Interstitial extends StatelessWidget {
  const Interstitial._({
    Key key,
  }) : super(key: key);

  static Route route({BetSlipCardCubit betSlipCardCubit}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider.value(
          value: betSlipCardCubit,
          child: const Interstitial._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetSlipCardCubit, BetSlipCardState>(
      builder: (context, state) {
        if (state is BetSlipCardOpened) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Interstitial Ad'),
                  OutlineButton(
                    child: const Text('Go Back'),
                    onPressed: () {
                      context.read<BetSlipCardCubit>().betSlipCardConfirm(
                            game: state.game,
                            cubit: state.cubit,
                            uniqueId: state.uniqueId,
                            currentPositionNumber: state.currentPositionNumber,
                            text: state.text,
                          );
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        } else {
          return const Text('Some Error Occurred');
        }
      },
    );
  }
}
