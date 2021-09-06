import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/textfield_outlines.dart';
import 'package:final_cs426/models/user.dart';
import 'package:final_cs426/screens/signup_screens/process_screen.dart';
import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatefulWidget {
  final Map user;
  PersonalInformationScreen({@required this.user});
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen>
    with WidgetsBindingObserver {
  String phone = "";
  String address = "";
  String birthdayString = "";
  bool first = true;
  DateTime birthday;
  final birthdayController = TextEditingController();
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
                        "Personal information",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          _generateTextFormField(
                              hintText: "Phone number",
                              onTextChanged: (value) {
                                phone = value;
                                first = false;
                              },
                              type: 0),
                          _generateTextFormField(
                              hintText: "Birthday",
                              onTextChanged: (value) {
                                address = value;
                              },
                              type: 1),
                          _generateTextFormField(
                              hintText: "Home address (optional)",
                              onTextChanged: (value) {
                                address = value;
                              },
                              type: 2),
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
                                      onPressed: () async {
                                        final bdStr =
                                            birthday.toIso8601String();

                                        Map user = {
                                          "firstName": widget.user["firstName"],
                                          "lastName": widget.user["lastName"],
                                          "username": widget.user["username"],
                                          "email": widget.user["email"],
                                          "password": widget.user["password"],
                                          "phone": phone,
                                          "dob": bdStr.substring(
                                                  0, bdStr.length - 4) +
                                              "Z",
                                        };

                                        if (address != null &&
                                            address.isNotEmpty)
                                          user["address"] = address;
                                        print(user);
                                        final result =
                                            await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProcessScreen(
                                                          user: user,
                                                          isSignIn: false,
                                                        )));
                                        if (result != null)
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    content: Text(
                                                        "Sign up failed",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ));
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
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
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

  Widget _generateTextFormField(
      {@required String hintText,
      @required ValueChanged<String> onTextChanged,
      @required int type}) {
    return GestureDetector(
      onTap: () async {
        if (type == 1) {
          final tmp = await showDatePicker(
              context: context,
              initialDate: birthday ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          if (tmp != null) {
            birthday = tmp;
          }
          if (birthday != null) {
            birthdayString =
                "${birthday.day}/${birthday.month}/${birthday.year}";
            birthdayController.text = birthdayString;
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: TextFormField(
          keyboardType: type == 0 ? TextInputType.phone : TextInputType.text,
          controller: type == 1 ? birthdayController : null,
          onChanged: (value) {
            onTextChanged(value);
          },
          enabled: type != 1,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            labelText: hintText,
            errorText: !first && type == 0 && !isPhoneNumberValid()
                ? "Invalid phone number"
                : null,
            contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
            disabledBorder:
                Theme.of(context).inputDecorationTheme.disabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
            focusedErrorBorder:
                Theme.of(context).inputDecorationTheme.focusedErrorBorder,
          ),
        ),
      ),
    );
  }

  bool isPhoneNumberValid() {
    {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = new RegExp(pattern);

      if (!regExp.hasMatch(phone)) {
        return false;
      }
      return true;
    }
  }

  bool _allInformationFilled() {
    print("password: ${phone.isNotEmpty && address.isNotEmpty}");
    return phone.isNotEmpty && birthdayString.isNotEmpty;
  }
}
