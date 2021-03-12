import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/repositories/sportsfeed_repository.dart';
import 'package:vegas_lit/features/history/bet_history.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';
import 'package:vegas_lit/features/home/widgets/widgets.dart';
import 'package:vegas_lit/features/leaderboard/view/leaderboard_page.dart';
import 'package:vegas_lit/features/open_bets/view/open_bets_page.dart';
import 'package:vegas_lit/features/slip/bet_slip.dart';
import 'package:vegas_lit/features/slip/cubit/bet_slip_cubit.dart';
import 'package:vegas_lit/features/sportsbook/bloc/sportsbook_bloc.dart';
import 'package:vegas_lit/features/sportsbook/view/sportsbook_page.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<SportsbookBloc>(
            create: (_) => SportsbookBloc(
              sportsfeedRepository: context.read<SportsfeedRepository>(),
            )..add(
                SportsbookOpen(
                  gameName: 'NBA',
                ),
              ),
          ),
          BlocProvider<BetSlipCubit>(
            create: (_) => BetSlipCubit()
              ..openBetSlip(
                betSlipGames: [],
              ),
          ),
          BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(),
          ),
        ],
        child: const HomePage._(),
      ),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final pageIndex =
        context.select((HomeCubit homeCubit) => homeCubit.state.pageIndex);
    final userId = context.select(
      (AuthenticationBloc authenticationBloc) =>
          authenticationBloc.state.user?.uid,
    );
    return Scaffold(
      backgroundColor: Palette.lightGrey,
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
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: IndexedStack(
        index: pageIndex,
        children: [
          Sportsbook(),
          BetSlip(),
          Leaderboard(),
          OpenBets.route(currentUserId: userId),
          BetHistory(),
        ],
      ),
      bottomNavigationBar: HomeBottomNavigation(),
    );
  }
}
