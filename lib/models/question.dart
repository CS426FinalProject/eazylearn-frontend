import 'package:flutter/cupertino.dart';

class Question {
  String requirement;
  String content;
  List<String> options;
  String answer;
  String explanation;
  Question(
      {@required this.requirement,
      @required this.content,
      @required this.options,
      @required this.answer,
      @required this.explanation});

  factory Question.fromJson(Map json) {
    String opts = json["choices"];
    String tmp = "";
    List<String> listOpts = [];
    for (int i = 0; i < opts.length; i++) {
      if (opts[i] != '|')
        tmp += opts[i];
      else {
        listOpts.add(tmp.trim());
        tmp = "";
      }
    }
    listOpts.add(tmp.trim());
    return Question(
        requirement: json["requirement"],
        content: json["content"],
        options: listOpts,
        answer: json["answer"].toString().trim(),
        explanation: json["reason"]);
  }
}
