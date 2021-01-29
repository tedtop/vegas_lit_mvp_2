import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/constants/palette.dart';

class Styles {
  static const double elevation = 8.0;

  // Team names on game card
  static final TextStyle h1 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  // Team names on game card
  static final TextStyle awayTeam = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  // Team names on game card
  static final TextStyle homeTeam = GoogleFonts.nunito(
    color: Palette.green,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );

  // Game card title
  static final TextStyle h2 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  // Bet type dividers
  static final TextStyle h3 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );

  // Game time
  static final TextStyle h4 = GoogleFonts.nunito(
    color: Palette.white,
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
  );

  // Bet button
  static final TextStyle betBtnText = GoogleFonts.nunito(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    color: Palette.white,
  );

  // For bet button selected
  static final TextStyle betBtnTextSelected = GoogleFonts.nunito(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Palette.darkGrey,
  );
}
