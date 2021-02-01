import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vegas_lit/constants/assets.dart';
import 'package:vegas_lit/constants/palette.dart';
import 'package:vegas_lit/constants/styles.dart';
import 'package:vegas_lit/features/bet_history/bet_history.dart';
import 'package:vegas_lit/features/bet_slip/bet_slip.dart';
import 'package:vegas_lit/features/bet_slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/leaderboard/leaderboard.dart';
import 'package:vegas_lit/features/open_bets/open_bets.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';
import 'package:vegas_lit/features/sportsbook/sportsbook.dart';

import '../sportsbook/bloc/sportsbook_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage._({Key key}) : super(key: key);

  static MultiBlocProvider route() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SportsbookBloc>(
          create: (context) => SportsbookBloc()
            ..add(
              SportsbookOpen(),
            ),
        ),
        BlocProvider<BetSlipCubit>(
          create: (context) => BetSlipCubit()
            ..openBetSlip(
              betSlipGames: [],
            ),
        ),
      ],
      child: const HomePage._(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: Image.asset(
          Images.topLogo,
          fit: BoxFit.contain,
          height: 80,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Balance',
                  style: Styles.h3,
                ),
                Text(
                  '\$100',
                  style: Styles.h3,
                ),
              ],
            ),
          )
        ],
      ),
      body: PageView(
        children: [
          Sportsbook(),
          BetSlip(),
          Leaderboard(),
          OpenBets(),
          BetHistory(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget bottomNavigation() {
    return BlocBuilder<BetSlipCubit, BetSlipState>(
      builder: (context, state) {
        if (state is BetSlipOpened) {
          final showBadge = state.games.isNotEmpty;
          final badgeCount = state.games.length;
          return CustomNavigationBar(
            elevation: 0,
            strokeColor: Palette.white,
            unSelectedColor: Palette.white,
            selectedColor: Palette.green,
            backgroundColor: Palette.darkGrey,
            currentIndex: pageIndex,
            onTap: onTap,
            items: [
              CustomNavigationBarItem(
                icon: const Icon(Feather.home),
                // title: const Text('Sportsbook'),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Feather.file_plus),
                showBadge: showBadge,
                badgeCount: badgeCount,
                // title: const Text('Bet Slip'),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Feather.globe),
                // title: const Text('Leaderboard'),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Feather.file_text),
                // title: const Text('Open Bets'),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Feather.calendar),
                // title: const Text('Bet History'),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  void onPageChanged(int pageIndex) {
    setState(
      () {
        this.pageIndex = pageIndex;
      },
    );
  }

  void onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
      // duration: const Duration(
      //   milliseconds: 100,
      // ),
      // curve: Curves.easeInOut,
    );
  }
}