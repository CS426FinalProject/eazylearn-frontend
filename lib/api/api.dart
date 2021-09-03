import 'dart:convert';

import 'package:final_cs426/constants/url.dart';
import 'package:final_cs426/models/user.dart';
import 'package:http/http.dart' as http;

class Session {
  static User user;
  static User defaultUser = User(
      userID: "userID",
      firstname: "firstname",
      lastname: "lastname",
      username: "username",
      dob: DateTime.now(),
      email: "email@email.com",
      phone: "0987654321");
}

class API {
  static Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };
  static Future<User> signUp(Map user) async {
    print(json.encode([user]));
    final response = await http.post(Uri.http(localURL, "/user/create"),
        headers: _headers, body: json.encode([user]));
    //print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body)["data"][0]);
      return User.fromJson(json.decode(response.body)["data"][0]);
    }

    return null;
  }
}
