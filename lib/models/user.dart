import 'package:final_cs426/api/API.dart';
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
  String totalTest;
  String avgScore;
  User(
      {@required this.userID,
      @required this.firstname,
      @required this.lastname,
      @required this.username,
      @required this.dob,
      @required this.email,
      @required this.phone,
      this.address,
      @required this.totalTest,
      @required this.avgScore});

  factory User.fromJson(Map json) {
    String dobStr = json["dob"];
    dobStr = dobStr.substring(0, dobStr.length - 1) + ".000";

    return User(
        userID: json["userId"].toString(),
        firstname: json["firstName"],
        lastname: json["lastName"],
        username: json["username"],
        dob: DateTime.parse(dobStr),
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        totalTest: json["totalTest"].toString(),
        avgScore: json["avgScore"].toString());
  }

  Map toJson() {
    String dobStr = dob.toIso8601String();
    print("fromjson");
    print(userID);
    dobStr = dobStr.substring(0, dobStr.length - 4) + "Z";
    print(dobStr);
    return {
      "userId": int.parse(userID),
      "firstName": firstname,
      "lastName": lastname,
      "dob": dobStr,
      "email": email,
      "phone": phone,
      "address": address
    };
  }
}
