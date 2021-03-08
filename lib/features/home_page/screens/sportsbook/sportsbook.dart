import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/home_page/screens/bet_slip/cubit/bet_slip_cubit.dart';

import 'bloc/sportsbook_bloc.dart';
import 'widgets/game_card/game_card.dart';
import 'widgets/home_interstitial.dart';

class Sportsbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportsbookBloc, SportsbookState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is SportsbookOpened) {
          Navigator.of(context).push<void>(
            Interstitial.route(),
          );
        }
      },
      builder: (context, state) {
        if (state is SportsbookOpened) {
          return SportsBookView(
            games: state.games,
            gameName: state.gameName,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SportsBookView extends StatelessWidget {
  const SportsBookView({
    Key key,
    @required this.games,
    @required this.gameName,
  })  : assert(games != null),
        assert(gameName != null),
        super(key: key);

  final List<Game> games;
  final String gameName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 8.0,
                  child: Container(
                    color: Palette.green,
                    padding: const EdgeInsets.all(8.0),
                    height: 40,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      isDense: true,
                      value: '$gameName',
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 0,
                      ),
                      style: Styles.h3,
                      onChanged: (String newValue) {
                        if (newValue != gameName) {
                          context.read<SportsbookBloc>().add(
                                SportsbookOpen(gameName: newValue),
                              );
                        }
                      },
                      items: <String>[
                        'NFL',
                        'NBA',
                        'MLB',
                        'NHL',
                        'NCAAF',
                        'NCAAB'
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: value == gameName
                                ? Text('$value (${games.length} Games)')
                                : Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'BET SLIP',
                      style: GoogleFonts.nunito(),
                    ),
                    BlocBuilder<BetSlipCubit, BetSlipState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case BetSlipStatus.opened:
                            return Container(
                              height: 22,
                              width: 22,
                              color: Palette.white,
                              child: Center(
                                child: Text(
                                  state.games.length.toString(),
                                  style: GoogleFonts.nunito(
                                    color: Palette.darkGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                            break;
                          default:
                            return const CircularProgressIndicator();
                            break;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<SportsbookBloc>().add(
                    SportsbookOpen(gameName: gameName),
                  );
            },
            child: Builder(
              builder: (context) {
                if (games.isEmpty) {
                  return const Center(
                    child: Text('No Games Found!'),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      return GameCard.route(
                        game: games[index],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
