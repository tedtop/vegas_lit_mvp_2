import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';

import '../cubit/home_cubit.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              Images.topLogo,
              fit: BoxFit.contain,
              height: 80,
            ),
            decoration: const BoxDecoration(
              color: Palette.lightGrey,
            ),
          ),
          ListTile(
            title: Text(
              'PROFILE',
              style: GoogleFonts.nunito(
                color: Palette.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'LEADERBOARD',
              style: GoogleFonts.nunito(
                color: Palette.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              context.read<HomeCubit>().homeChange(2);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Text(
              'LOGOUT',
              style: GoogleFonts.nunito(
                color: Palette.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              context.read<AuthenticationBloc>().add(
                    AuthenticationLogoutRequested(),
                  );
            },
          ),
          ListTile(
            title: Text(
              'RULES',
              style: Styles.h3,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'FAQ',
              style: Styles.h3,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'TERMS OF SERVICE',
              style: Styles.h3,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'PRIVACY POLICY',
              style: Styles.h3,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'CONTACT US',
              style: Styles.h3,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
