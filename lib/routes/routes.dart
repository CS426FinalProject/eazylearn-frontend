import 'package:final_cs426/screens/home_screen.dart';
import 'package:final_cs426/screens/profile_screens/profile_screen.dart';
import 'package:final_cs426/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final String splash = "/splash";
  static final String login = "/login";
  static final String home = "/home";
  static final String profile = "/profile";

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    // login
    home: (context) => HomeScreen(),
    //profile: (context) => ProfileScreen()
  };
}
