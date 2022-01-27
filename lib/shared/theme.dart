import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = const Color(0xff373A44);
Color kSecondaryColor = const Color(0xff5B5B5B);
Color kBackgroundColor = const Color(0xffFAFAFA);
Color kBlueColor = const Color(0xff4A7CDB);
Color kGreyColor = const Color(0xff9698A9);
Color kGreyColor1 = const Color(0xffD0D0D0);
Color kRedColor = const Color(0xffFB4470);
Color kGreenColor = const Color(0xff4ADB6A);
Color kWhiteColor = const Color(0xffFFFFFF);

const List<Color> colors = [
  Color(0xFFFF0000),
  Color(0xff3369FF),
  Color(0xFFF6AE22),
  Color(0xff13B837),
  Color(0xff8A2BE2),
  // Colors.blue,
  // Colors.lightBlue,
  // Colors.cyan,
  // Colors.teal,
  // Colors.green,
  // Colors.lightGreen,
  // Colors.lime,
  // Colors.yellow,
  // Colors.amber,
  // Colors.orange,
  // Colors.deepOrange,
  // Colors.brown,
  // Colors.grey,
  // Colors.blueGrey,
  // Colors.black,
];

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);
TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
