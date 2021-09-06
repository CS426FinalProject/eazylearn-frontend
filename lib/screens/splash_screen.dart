import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/screens/signin_screen.dart';
import 'package:final_cs426/screens/signup_screens/basic_information_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool init = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      await Future.delayed(Duration(milliseconds: 1000));
      setState(() => init = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 700),
          curve: Curves.ease,
          height: init ? MediaQuery.of(context).size.height : 250,
          width: MediaQuery.of(context).size.width,
          alignment: init ? Alignment.center : Alignment.bottomCenter,
          child: Text(
            "WELCOME TO\nEAZYLEARN",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ),
        Center(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 1100),
            transitionBuilder: (child, animation) =>
                FadeTransition(child: child, opacity: animation),
            child: init ? SizedBox.shrink() : _the2buttons(),
          ),
        ),
      ],
    ));
  }

  Widget _the2buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignupScreen()));
          },
          child: Text(
            "I want to register",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor),
              minimumSize: MaterialStateProperty.all(Size(300, 60)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)))),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: Text(
            "I have an account",
            style: Theme.of(context).textTheme.headline5,
          ),
        )
      ],
    );
  }
}
