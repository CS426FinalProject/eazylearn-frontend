import 'package:final_cs426/models/answer.dart';
import 'package:flutter/cupertino.dart';

class Question {
  String question;
  String equation;
  List<Answer> options;
  int answer;
  String explanation;
  Question(
      {@required this.question,
      @required this.equation,
      @required this.options,
      @required this.answer,
      @required this.explanation});
}
