import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/models/user.dart';
import 'package:final_cs426/routes/routes.dart';
import 'package:final_cs426/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ProcessScreen extends StatefulWidget {
  final Map user;
  final bool isSignIn;
  ProcessScreen({@required this.user, @required this.isSignIn});
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  bool init = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      var result;
      if (widget.isSignIn)
        result = await API.signIn(widget.user);
      else
        result = await API.signUp(widget.user);
      if (result != null) {
        Session.userID = result;
        print(Session.userID);
        setState(() => init = false);
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pushNamed(Routes.home);
      } else
        Navigator.pop(context, false);
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
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "In process...",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                )
              ],
            )
          : Text(
              "EAZYLEARN",
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
    )));
  }
}
