import 'package:final_cs426/routes/routes.dart';
import 'package:final_cs426/screens/result_screen.dart';
import 'package:final_cs426/screens/splash_screen.dart';
import 'package:final_cs426/screens/test_choosing_screen.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'constants/colors.dart';

final ThemeData _kEzLearnTheme = _buildEzLearnTheme();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EazyLearn',
      theme: _kEzLearnTheme,
      routes: Routes.routes,
      initialRoute: Routes.splash,
    );
  }
}

ThemeData _buildEzLearnTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kEzLearnBlue600,
      primaryVariant: kEzLearnBlue900,
      onPrimary: kEzLearnWhite,
      secondary: kEzLearnYellow400,
      onSecondary: kEzLearnBlack,
      background: kEzLearnWhite,
      onBackground: kEzLearnBlack,
      surface: kEzLearnWhite,
      onSurface: kEzLearnBlack,
      error: kEzLearnErrorRed,
    ),
    scaffoldBackgroundColor: kEzLearnWhite,
    textTheme: _buildEzLearnTextTheme1(base.textTheme),
    accentTextTheme: _buildEzLearnTextTheme2(base.textTheme),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kEzLearnGrey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kEzLearnBlue600, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kEzLearnWrongRed, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kEzLearnWrongRed, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kEzLearnGrey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kEzLearnGrey, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );
}

TextTheme _buildEzLearnTextTheme1(TextTheme base) {
  return base
      .copyWith(
        headline4: base.headline4.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: 36,
          height: 1.2,
          letterSpacing: 1,
        ),
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 28,
          height: 1.2,
          letterSpacing: 0.5,
          color: kEzLearnBlack,
        ),
        headline6: base.headline6.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1.4,
          color: kEzLearnBlack,
        ),
        subtitle1: base.subtitle1.copyWith(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          fontSize: 14,
          height: 1.4,
          color: kEzLearnGrey,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1.4,
          color: kEzLearnBlack,
        ),
        bodyText2: base.bodyText2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 1.3,
          color: kEzLearnBlack,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          letterSpacing: 0.5,
          color: kEzLearnBlack,
        ),
      )
      .apply(
        fontFamily: 'Raleway',
        displayColor: kEzLearnWhite,
      );
}

TextTheme _buildEzLearnTextTheme2(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w700, // Bold
          fontSize: 24,
          height: 1.2,
        ),
        headline6: base.headline6.copyWith(
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 18,
          height: 1.2,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1.2,
        ),
      )
      .apply(
        fontFamily: 'OpenSans',
        bodyColor: kEzLearnBlack,
      );
}
