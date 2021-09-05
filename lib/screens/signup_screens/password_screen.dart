import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/screens/signup_screens/personal_information_screen.dart';
import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  final Map user;
  PasswordScreen({@required this.user});
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
    with WidgetsBindingObserver {
  String password = "";
  String reentering = "";
  bool passwordObscure = true;
  bool reenteringObscure = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(
            40,
            0,
            40,
            MediaQuery.of(context).viewInsets.bottom == 0 ? 30 : 0,
          ),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Create new password",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _generateTextFormField(
                        hintText: "Password",
                        onTextChanged: (value) {
                          password = value;
                        },
                        obscure: passwordObscure,
                        isPassword: true),
                    _generateTextFormField(
                        hintText: "Re-enter password",
                        onTextChanged: (value) {
                          reentering = value;
                        },
                        obscure: reenteringObscure,
                        isPassword: false),
                  ],
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: _allInformationFilled()
                              ? ElevatedButton(
                                  onPressed: () {
                                    Map user = {
                                      "firstName": widget.user["firstName"],
                                      "lastName": widget.user["lastName"],
                                      "username": widget.user["username"],
                                      "email": widget.user["email"],
                                      "password": password
                                    };
                                    print(user);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PersonalInformationScreen(
                                                  user: user,
                                                )));
                                  },
                                  child: Text(
                                    "Next",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(300, 55)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)))),
                                )
                              : SizedBox.shrink()))
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    // if (value == 0) {
    //   setState(() {
    //     FocusScope.of(context).unfocus();
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Padding _generateTextFormField(
      {@required String hintText,
      @required ValueChanged<String> onTextChanged,
      @required bool obscure,
      @required bool isPassword}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextFormField(
        onChanged: (value) {
          onTextChanged(value);
        },
        style: Theme.of(context).textTheme.headline6,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isPassword
                    ? passwordObscure = !passwordObscure
                    : reenteringObscure = !reenteringObscure;
              });
            },
          ),
          labelText: hintText,
          errorText: isPassword
              ? null
              : (password != reentering
                  ? "Passwords should be the same"
                  : null),
          errorStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 14,
                color: Theme.of(context).colorScheme.error,
              ),
          contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          enabledBorder: Theme.of(context).inputDecorationTheme.border,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red, width: 2)),
        ),
      ),
    );
  }

  bool _allInformationFilled() {
    print("password: ${password.isNotEmpty && reentering.isNotEmpty}");
    return password.isNotEmpty &&
        reentering.isNotEmpty &&
        password == reentering;
  }
}
