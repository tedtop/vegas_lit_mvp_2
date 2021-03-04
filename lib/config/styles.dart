import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';

class Styles {
  static const double elevation = 8.0;

  static final TextStyle h1 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

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
    fontSize: 10.0,
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
    fontSize: 10.0,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle emptySlipText = TextStyle(
    color: Colors.grey,
    fontSize: 15,
  );

  static final TextStyle headingLeaderboard = GoogleFonts.nunito(
    color: Palette.green,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );
}
