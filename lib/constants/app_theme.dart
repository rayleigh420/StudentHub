/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your setting, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created setting or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/setting.dart';`
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: Color(0xFF4285F4), // Màu chủ đạo của Google
      appBarTheme: _appBarTheme(colorScheme),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colorScheme),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1!.apply(color: _darkFillColor),
      ),
      // buttonTheme: ButtonThemeData(buttonColor: colorScheme.brightness == Brightness.dark ? '0xFF22272e' : )
    );
  }

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.background,
      elevation: 0.25,
      iconTheme: IconThemeData(color: colorScheme.primary),
      shape: Border(
          bottom: BorderSide(
              width: 0.2,
              color: colorScheme.brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.3)
                  : Colors.black.withOpacity(0.3))),
      titleTextStyle: TextStyle(
          color: colorScheme.brightness == Brightness.light
              ? colorScheme.onBackground
              : Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold),
      // Các thiết lập khác cho AppBar ở đây...
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
      ColorScheme colorScheme) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.background,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onBackground.withOpacity(0.6),
      elevation: 0.25,
      type: BottomNavigationBarType.fixed,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF4285F4), // Màu chủ đạo của Google
    primaryContainer: Color(0xFF9e1718),
    secondary: Color(0xFF0F9D58), // Màu phụ của Google
    secondaryContainer: Color(0xFFDB4437), // Màu phụ của Google
    background: Color(0xFFFCFCFC), // Màu nền của Google
    surface: Color(0xFFFFFFFF),
    onBackground: Colors.black,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF4285F4), // Màu chủ đạo của Google
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    background: Color(0xFF2D333B),
    // background: Color(0xFF2e3239),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline4: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    caption: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    headline5: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    subtitle1: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    overline: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    bodyText1: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    subtitle2: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    bodyText2: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    headline6: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    button: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );
}

class AppInsTheme {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.black, // Màu chủ đạo là đen
    primaryContainer: Color(0xFF484848), // Màu container phụ tối
    secondary: Colors.white, // Màu chữ phụ là trắng
    secondaryContainer: Color(0xFFEDEDED), // Màu container phụ sáng
    background: Colors.white, // Màu nền là trắng
    surface: Colors.white,
    onBackground: Colors.black,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Colors.white, // Màu chủ đạo là trắng
    primaryContainer: Color(0xFF616161), // Màu container phụ tối
    secondary: Colors.black, // Màu chữ phụ là đen
    secondaryContainer: Color(0xFF303030), // Màu container phụ sáng
    background: Colors.black, // Màu nền là đen
    surface: Color(0xFF121212),
    onBackground: Colors.white,
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline4: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    caption: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    headline5: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    subtitle1: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    overline: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    bodyText1: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    subtitle2: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    bodyText2: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    headline6: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    button: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );
}
