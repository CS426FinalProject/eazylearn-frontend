import 'dart:convert';

import 'package:final_cs426/constants/url.dart';
import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Session {
  static String userID;
  static final String defaultUserID = "3";
}

class API {
  static Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };
  static Future<String> signUp(Map user) async {
    final response = await http.post(Uri.http(localURL, "/user/create"),
        headers: _headers, body: json.encode([user]));
    if (response.statusCode == 200) {
      return json.decode(response.body)["data"][0]["userId"].toString();
    }
    return null;
  }

  static Future<String> signIn(Map user) async {
    final response =
        await http.post(Uri.http(localURL, "login"), body: json.encode(user));
    if (response.statusCode == 200) {
      Map body = json.decode(response.body);
      if (body["data"].toString() != "false") {
        Session.userID = json.decode(response.body)["data"].toString();
        return Session.userID;
      }
    }
    return null;
  }

  static Future<User> getProfile(String id, BuildContext context) async {
    final param = {"id": id};
    final response = await http.get(
      Uri.http(localURL, "/user/profile", param),
    );
    if (response.statusCode == 200) {
      User user = User.fromJson(json.decode(response.body)["data"]);
      return user;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.body)));
    return null;
  }

  static Future<bool> editUser(User user) async {
    final response = await http.put(Uri.http(localURL, "/user/edit"),
        body: json.encode(user.toJson()));
    return response.statusCode == 200;
  }

  static Future<List<Subject>> getAllSubject(BuildContext context) async {
    final response =
        await http.get(Uri.http(localURL, "/subjects"), headers: _headers);
    if (response.statusCode == 200) {
      Iterable i = json.decode(response.body)["data"];
      int count = 0;
      List<Subject> subjects =
          List.from(i.map((e) => Subject.fromJson(e, count++)).toList());
      return subjects;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.body)));
    return null;
  }

  static Future<List<Topic>> getAllTopicBySubject(
      String subjectID, BuildContext context) async {
    final param = {"subjectId": subjectID};
    final response = await http.get(
      Uri.http(localURL, "/topic/all", param),
    );
    if (response.statusCode == 200) {
      Iterable i = json.decode(response.body)["data"];
      List<Topic> topics = List.from(i.map((e) => Topic.fromJson(e)));
      return topics;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.body)));
    return null;
  }

  static Future<Topic> getTopicByID(String id) async {
    final param = {"id": id};
    final response = await http.get(Uri.http(localURL, "/topic/find", param));
    if (response.statusCode == 200) {
      return Topic.fromJson(json.decode(response.body)["data"]);
    }

    return null;
  }

  static Future<List<Test>> getTestByTopicIDs(
      List<String> topicIDs, BuildContext context) async {
    String param = json.encode({"TopicId": topicIDs});
    final response = await http.get(Uri.http(localURL, "/test/", {"q": param}));
    print(response.request.url);
    if (response.statusCode == 200) {
      Iterable mapIterable = json.decode(response.body)["data"];
      List<Test> tests = [];
      for (int i = 0; i < mapIterable.length; i++) {
        Test tmp = await Test.fromJson(mapIterable.elementAt(i));
        tests.add(tmp);
      }
      return tests;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.body)));
    return null;
  }
}
