part of "shared.dart";

// final setLightTheme = buildLightTheme();
// final setDarkTheme = buildDarkTheme();

ThemeData buildLightTheme(String primaryColorInput) {
  return ThemeData(
    primaryColor: HexColor(primaryColorInput), //customizable const (future)
    brightness: Brightness.light,
    backgroundColor: HexColor("FAFAFA"),
    accentColor: HexColor("1B1F28"),
    accentIconTheme: IconThemeData(color: HexColor("030835")),
    dividerColor: Colors.white54,
  );
}

ThemeData buildDarkTheme(String primaryColorInput) {
  return ThemeData(
    primaryColor: HexColor(primaryColorInput), //customizable
    scaffoldBackgroundColor:HexColor("1A1B2F"),
    brightness: Brightness.dark,
    backgroundColor: HexColor("1A1B2F"),
    accentColor: HexColor("FAFAFA"),
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: HexColor("1A1B2F"),
  );
}

TextStyle t42Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 42,
    fontWeight: FontWeight.w500
);

TextStyle t36Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 36,
    fontWeight: FontWeight.w500
);

TextStyle t32Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2
);

TextStyle t28Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2
);

TextStyle t24Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 24,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2
);

TextStyle t18Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
);

TextStyle t16Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 16,
    fontWeight: FontWeight.w100
);

TextStyle t14Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 14,
    fontWeight: FontWeight.w500
);


TextStyle t12Dark = GoogleFonts.montserrat().copyWith(
    color: buildDarkTheme('a').accentColor,
    fontSize: 12,
    fontWeight: FontWeight.w500
);

TextStyle t42Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 42,
    fontWeight: FontWeight.w500
);

TextStyle t36Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 36,
    fontWeight: FontWeight.w500
);

TextStyle t32Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 32,
    fontWeight: FontWeight.w500
);

TextStyle t28Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2
);

TextStyle t24Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 24,
    fontWeight: FontWeight.w500
);

TextStyle t18Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 18,
    fontWeight: FontWeight.w500
);

TextStyle t16Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 16,
    fontWeight: FontWeight.w500
);

TextStyle t14Light = GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 14,
    fontWeight: FontWeight.w500
);


TextStyle t12Light= GoogleFonts.montserrat().copyWith(
    color: buildLightTheme('a').accentColor,
    fontSize: 12,
    fontWeight: FontWeight.w500
);

