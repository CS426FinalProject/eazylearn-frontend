import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:flutter/material.dart';

class TestPreview {
  String name;
  int time;
  int difficulty;
  String description;
  Color color;
  Subject subject;
  List<Topic> topics;
  TestPreview(
      {@required this.name,
      @required this.time,
      @required this.subject,
      @required this.topics,
      @required this.difficulty,
      @required this.description,
      @required this.color});
}
