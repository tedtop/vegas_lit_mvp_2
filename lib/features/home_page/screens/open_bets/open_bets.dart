import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';
import 'package:vegas_lit/features/home_page/screens/open_bets/cubit/open_bets_cubit.dart';

import 'open_bets_slip.dart';

class OpenBets extends StatelessWidget {
  static Builder route({String currentUserId}) {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => OpenBetsCubit(
            betsRepository: context.read<BetsRepository>(),
          )..openBetsOpen(
              currentUserId: currentUserId,
            ),
          child: OpenBets(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightGrey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'OPEN BETS',
                  style: Styles.headingLeaderboard,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(
                    fontSize: 14, fontWeight: FontWeight.w300),
                children: <TextSpan>[
                  const TextSpan(
                      text:
                          'Bets shown here cannot be modified and are awaiting the outcome of the event. Once bets have been closed they will appear in your'),
                  TextSpan(
                      text: ' BET HISTORY ',
                      style: GoogleFonts.nunito(
                        color: Palette.green,
                      )),
                  const TextSpan(text: 'page.'),
                ],
              ),
            ),
          ),
          const TextBar(
            text: 'Ascending - by start time',
          ),
          BlocBuilder<OpenBetsCubit, OpenBetsState>(
            builder: (context, state) {
              if (state is OpenBetsOpened) {
                if (state.openBets.isEmpty) {
                  return Center(
                    child: Text(
                      'No open bet slips found!',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    key: Key('${state.openBets.length}'),
                    itemCount: state.openBets.length,
                    itemBuilder: (context, index) {
                      return OpenBetsSlip(
                        openBets: state.openBets[index],
                      );
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 8.0,
        child: Container(
          color: Palette.darkGrey,
          padding: const EdgeInsets.all(8.0),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Styles.h3,
              ),
              const Icon(
                LineAwesomeIcons.arrow_down,
              )
            ],
          ),
        ),
      ),
    );
  }
}
