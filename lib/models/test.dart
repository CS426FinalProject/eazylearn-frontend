import 'package:final_cs426/models/question.dart';
import 'package:flutter/cupertino.dart';

class Test {
  String idTest;
  String topic;
  List<Question> questions;

  Test({@required this.idTest, @required this.topic, @required this.questions});
}
