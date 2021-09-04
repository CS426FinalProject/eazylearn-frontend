import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/user.dart';
import 'package:final_cs426/routes/routes.dart';
import 'package:final_cs426/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ProcessScreen extends StatefulWidget {
  final Map user;
  ProcessScreen({@required this.user});
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  bool init = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      final result = await API.signUp(widget.user);
      if (result != null) {
        Session.user = result;
        setState(() => init = false);
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pushNamed(Routes.home);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("error")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: init
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: primaryColor,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "In process...",
                  style: TextStyle(color: primaryColor, fontSize: 20),
                )
              ],
            )
          : Text(
              "EAZYLEARN",
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
    )));
  }
}
