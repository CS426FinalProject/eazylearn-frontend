
import 'package:final_cs426/screens/signup_screens/password_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with WidgetsBindingObserver {
  String firstname = "";
  String lastname = "";
  String accountName = "";
  String email = "";
  bool isFirst = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    print(_allInformationFilled());
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
                        "Create new account",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: MediaQuery.of(context).viewInsets.bottom == 0 ? 5 : 7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          _generateTextFormField(
                              hintText: "First name",
                              onTextChanged: (value) {
                                firstname = value;
                              }),
                          _generateTextFormField(
                              hintText: "Last name",
                              onTextChanged: (value) {
                                lastname = value;
                              }),
                          _generateTextFormField(
                              hintText: "Account name",
                              onTextChanged: (value) {
                                accountName = value;
                              }),
                          _generateTextFormField(
                              hintText: "Email address",
                              onTextChanged: (value) {
                                isFirst = false;
                                email = value;
                              }),
                        ],
                      ),
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
                                          "firstName": firstname,
                                          "lastName": lastname,
                                          "username": accountName,
                                          "email": email
                                        };
                                        print(user);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PasswordScreen(
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
                                        minimumSize: MaterialStateProperty.all(
                                            Size(double.infinity, 55)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()))
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Container(
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

  Widget _generateTextFormField(
      {@required String hintText,
      @required ValueChanged<String> onTextChanged}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextFormField(
        onChanged: (value) {
          onTextChanged(value);
        },
        style: Theme.of(context).textTheme.headline6,
        decoration: InputDecoration(
          labelText: hintText,
          errorText: !isFirst &&
                  hintText == "Email address" &&
                  !EmailValidator.validate(email)
              ? "Your email is invalid"
              : null,
          errorStyle: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 10,
                color: Theme.of(context).colorScheme.error,
              ),
          contentPadding: EdgeInsets.fromLTRB(25, 20, 10, 20),
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
    return firstname.isNotEmpty &&
        lastname.isNotEmpty &&
        accountName.isNotEmpty &&
        email.isNotEmpty &&
        EmailValidator.validate(email);
  }
}
