import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:vegas_lit/features/game_card/game_card.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';

class Sportsbook extends StatefulWidget {
  @override
  _SportsbookState createState() => _SportsbookState();
}

class _SportsbookState extends State<Sportsbook>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SportsbookBloc, SportsbookState>(
      builder: (context, state) {
        if (state is SportsbookOpened) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8.0,
                  child: Container(
                    color: Palette.green,
                    padding: const EdgeInsets.all(8.0),
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'NFL Games (13 Games)',
                          style: Styles.h3,
                        ),
                        const Icon(Icons.download_rounded)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.games.length,
                  itemBuilder: (context, index) {
                    return GameCard(
                      game: state.games[index],
                    );
                  },
                ),
              ),
            ],
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
