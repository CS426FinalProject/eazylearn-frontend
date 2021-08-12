import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/textfield_outlines.dart';
import 'package:final_cs426/screens/signup_screens/process_screen.dart';
import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatefulWidget {
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
                    "Personal information",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProcessScreen()));
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
    if (value == 0) {
      setState(() {
        FocusScope.of(context).unfocus();
      });
    }
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
          controller: type == 1 ? birthdayController : null,
          onChanged: (value) {
            onTextChanged(value);
          },
          enabled: type != 1,
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              labelText: hintText,
              errorText: !first && type == 0 && !isPhoneNumberValid()
                  ? "Invalid phone number"
                  : null,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 20),
              contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
              disabledBorder: outline,
              focusedBorder: outline,
              enabledBorder: outline,
              errorBorder: errorOutline,
              focusedErrorBorder: errorOutline),
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
    return phone.isNotEmpty && address.isNotEmpty && birthdayString.isNotEmpty;
  }
}
