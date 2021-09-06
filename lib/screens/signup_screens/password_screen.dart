import 'package:final_cs426/constants/colors.dart';
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
        body: Stack(
          children: [
            Container(
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(double.infinity, 55)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)))),
                                    )
                                  : SizedBox.shrink()))
                      : SizedBox.shrink(),
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
            icon: Icon(
              obscure ? Icons.visibility : Icons.visibility_off,
              color: isPassword
                  ? null
                  : (password != reentering
                      ? Theme.of(context).colorScheme.error
                      : kEzLearnGrey),
            ),
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
          errorStyle: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 10,
                color: Theme.of(context).colorScheme.error,
              ),
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

  bool _allInformationFilled() {
    print("password: ${password.isNotEmpty && reentering.isNotEmpty}");
    return password.isNotEmpty &&
        reentering.isNotEmpty &&
        password == reentering;
  }
}
