import 'package:email_validator/email_validator.dart';
import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/textfield_outlines.dart';
import 'package:final_cs426/models/user.dart';
import 'package:flutter/material.dart';

class ProfileEdittingScreen extends StatefulWidget {
  final User user;
  ProfileEdittingScreen({@required this.user});
  @override
  _ProfileEdittingScreenState createState() => _ProfileEdittingScreenState();
}

class _ProfileEdittingScreenState extends State<ProfileEdittingScreen> {
  User user;
  List<String> hintTexts = [
    "First name",
    "Last name",
    "Username",
    "Email",
    "Birthday",
    "Phone num",
    "Home address (optional)"
  ];
  List<String> inputs;
  List<TextEditingController> controllers;
  DateTime dob;

  @override
  void initState() {
    user = widget.user;
    dob = user.dob;
    super.initState();
    inputs = [
      user.firstname,
      user.lastname,
      user.username,
      user.email,
      "${dob.day}/${dob.month}/${dob.year}",
      user.phone,
      user.address
    ];
    controllers = List.generate(hintTexts.length,
        (index) => TextEditingController(text: inputs[index]));
  }

  @override
  void dispose() {
    super.dispose();
    for (TextEditingController controller in controllers) controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      iconSize: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edit profile",
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: ListView.separated(
                  itemCount: hintTexts.length + 1,
                  itemBuilder: (context, index) => index == hintTexts.length
                      ? _buildTwoButtons()
                      : _generateTextFormField(
                          controller: controllers[index],
                          hintText: hintTexts[index],
                          row: index,
                          onTextChanged: (value) {
                            setState(() {
                              inputs[index] = value;
                            });
                          }),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 25,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTwoButtons() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          !isAllValid()
              ? SizedBox.shrink()
              : ElevatedButton(
                  onPressed: () {
                    user = User(
                        userID: widget.user.userID,
                        firstname: inputs[0],
                        lastname: inputs[1],
                        username: inputs[2],
                        email: inputs[3],
                        dob: dob,
                        phone: inputs[5],
                        address: inputs[6]);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Apply",
                    style: Theme.of(context).accentTextTheme.headline6,
                  ),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(100, 40)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor:
                          MaterialStateProperty.all(secondaryColor))),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: Theme.of(context).accentTextTheme.headline6,
            ),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.black.withOpacity(0.07)),
            ),
          )
        ],
      ),
    );
  }

  Widget _generateTextFormField(
      {@required String hintText,
      @required int row,
      @required TextEditingController controller,
      @required ValueChanged<String> onTextChanged}) {
    return GestureDetector(
      onTap: () async {
        if (row == 4) {
          final choice = await showDatePicker(
              context: context,
              initialDate: dob,
              firstDate: DateTime(1900),
              lastDate: DateTime.now());

          if (choice != null) {
            dob = choice;
            controllers[row].text =
                inputs[row] = "${dob.day}/${dob.month}/${dob.year}";
          }
        }
      },
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          onTextChanged(value);
        },
        enabled: row != 4,
        keyboardType: row == 5 ? TextInputType.phone : TextInputType.text,
        style: Theme.of(context).textTheme.headline6,
        decoration: InputDecoration(
          labelText: hintText,
          errorText: row == 3 && !EmailValidator.validate(inputs[row])
              ? "Your email is invalid"
              : (row == 5 && !isPhoneNumberValid(inputs[row])
                  ? "Your phone is invalid"
                  : null),
          focusColor: Theme.of(context).colorScheme.primary,
          contentPadding: EdgeInsets.fromLTRB(25, 20, 10, 20),
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          border: Theme.of(context).inputDecorationTheme.border,
          errorBorder: errorOutline,
          focusedErrorBorder: errorOutline,
        ),
        maxLines: row == 6 ? null : 1,
      ),
    );
  }

  bool isPhoneNumberValid(String phone) {
    {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = new RegExp(pattern);

      if (!regExp.hasMatch(phone)) {
        return false;
      }
      return true;
    }
  }

  bool isAllValid() {
    for (int i = 0; i < inputs.length - 1; i++) {
      if (i == 3 && !EmailValidator.validate(inputs[i]))
        return false;
      else if (i == 5 && !isPhoneNumberValid(inputs[i]))
        return false;
      else if (inputs[i].isEmpty) return false;
    }
    return true;
  }
}
