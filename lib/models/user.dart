import 'package:flutter/material.dart';

class User {
  String userID;
  String firstname;
  String lastname;
  String username;
  DateTime dob;
  String email;
  String phone;
  String address;

  User(
      {@required this.userID,
      @required this.firstname,
      @required this.lastname,
      @required this.username,
      @required this.dob,
      @required this.email,
      @required this.phone,
      this.address});

  factory User.fromJson(Map json) {
    String dobStr = json["dob"];
    dobStr = dobStr.substring(0, dobStr.length - 1) + ".000";
    print(dobStr);
    return User(
        userID: json["userId"].toString(),
        firstname: json["firstName"],
        lastname: json["lastName"],
        username: json["username"],
        dob: DateTime.parse(dobStr),
        email: json["email"],
        phone: json["phone"],
        address: json["address"]);
  }

  Map toJson() {
    String dobStr = dob.toIso8601String();
    dobStr = dobStr.substring(0, dobStr.length - 4) + "Z";
    return {
      "firstName": firstname,
      "lastName": lastname,
      "dob": dobStr,
      "email": email,
      "phone": phone,
      "address": address
    };
  }
}
