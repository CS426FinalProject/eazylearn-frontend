import 'package:final_cs426/screens/home_screen.dart';
import 'package:final_cs426/screens/result_screen.dart';
import 'package:final_cs426/screens/splash_screen.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: HomeScreen(),
    );
  }
}
