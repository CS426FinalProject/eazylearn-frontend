
import 'package:final_cs426/screens/signup_screens/process_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String username = "";
  String password = "";
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 30),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Log in",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _generateTextFormField(
                              hintText: "Username",
                              onTextChanged: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                              isPassword: false),
                          _generateTextFormField(
                              hintText: "Password",
                              onTextChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              isPassword: true)
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: (username.isEmpty || password.isEmpty)
                        ? SizedBox.shrink()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () async {
                                final user = {
                                  "username": username,
                                  "password": password
                                };
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProcessScreen(
                                            user: user, isSignIn: true)));
                                if (result != null)
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            content: Text(
                                              "Failed to login",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ));
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                                minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 55)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              child: Text("Next",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary)),
                            ),
                          ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 35),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  iconSize: 40,
                ))
          ],
        ),
      ),
    );
  }

  Widget _generateTextFormField(
      {@required String hintText,
      @required ValueChanged<String> onTextChanged,
      @required bool isPassword}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextFormField(
        onChanged: (value) {
          onTextChanged(value);
        },
        style: Theme.of(context).textTheme.headline6,
        obscureText: isPassword && isObscure,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off))
              : null,
          labelText: hintText,
          contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
          disabledBorder: Theme.of(context).inputDecorationTheme.disabledBorder,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
          focusedErrorBorder:
              Theme.of(context).inputDecorationTheme.focusedErrorBorder,
        ),
      ),
    );
  }
}
