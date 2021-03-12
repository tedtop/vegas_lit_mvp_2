import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';

class Styles {
  // This is for the green page headings, should be green 36 bold with drop shadow
  static final TextStyle h1 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
  );

  // size 36 green bold with drop shadow for page titles
  // size 24 white for Open Bets "TITANS TO WIN"

  // size 18 white bold for green buttons & dropdown menus, with drop shadow
  // size 18 white regular for red buttons, which drop shadow

  // size 18 white for all default text
  // size 18 green bold, for green text inline with 18 white text

  // size 14 white for disclaimer text on signup
  // size 14 bold for social button labels & selected botton nav item

  // size 12 white for game times
  // size 12 red for game time countdown

  static final TextStyle h2 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle h3 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle h4 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
  );

  static final TextStyle awayTeam = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle homeTeam = GoogleFonts.nunito(
    color: Palette.green,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle betBtnText = GoogleFonts.nunito(
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    color: Palette.white,
  );

  static final TextStyle betBtnTextSelected = GoogleFonts.nunito(
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
    color: Palette.darkGrey,
  );

  static final TextStyle startingTimeText = GoogleFonts.nunito(
    color: Palette.red,
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle emptySlipText = TextStyle(
    color: Colors.grey,
    fontSize: 15,
  );

  static final TextStyle headingLeaderboard = GoogleFonts.nunito(
    color: Palette.green,
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
  );
}
