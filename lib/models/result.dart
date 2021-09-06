import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/models/test.dart';
import 'package:flutter/material.dart';

class Result {
  DateTime timeStart;
  DateTime timeEnd;
  List<String> answer;
  String userID;
  Test test;

  Result(
      {@required this.userID,
      @required this.test,
      @required this.answer,
      @required this.timeStart,
      @required this.timeEnd});

  static Future<Result> fromJson(Map json) async {
    String start = json["timeStart"];
    String end = json["timeEnd"];

    start = start.substring(0, start.length - 1) + "4963";
    end = end.substring(0, end.length - 1) + "4963";
    Iterable i = json["answer"];
    List<String> answer = List.of(i.map((e) => e.toString()));

    Test test = await API.getTestByID(json["testId"].toString());

    //print(DateTime.parse("2021-09-06T17:15:32.580999"));
    return Result(
        userID: json["userId"].toString(),
        test: test,
        answer: answer,
        timeStart: DateTime.parse(json["timeStart"].toString()),
        timeEnd: DateTime.parse(json["timeEnd"].toString()));
  }

  Map toJson() {
    String start = timeStart.toIso8601String();
    String end = timeEnd.toIso8601String();
    start = start.substring(0, start.length - 4) + "Z";
    end = end.substring(0, start.length - 4) + "Z";
    return {
      "userId": int.parse(Session.userID),
      "testId": test.testID,
      "answer": answer,
      "timeStart": start,
      "timeEnd": end
    };
  }
}
