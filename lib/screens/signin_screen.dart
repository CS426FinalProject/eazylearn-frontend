import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/textfield_outlines.dart';
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
                          child: Text("Log in"))),
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
                                            content: Text("Failed to login"),
                                          ));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                                minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 55)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                              ),
                              child: Text("Next"),
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
        style: TextStyle(fontSize: 20),
        obscureText: isPassword && isObscure,
        decoration: InputDecoration(
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off))
                : null,
            labelText: hintText,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 20),
            contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
            disabledBorder: outline,
            focusedBorder: outline,
            enabledBorder: outline,
            errorBorder: errorOutline,
            focusedErrorBorder: errorOutline),
      ),
    );
  }
}
