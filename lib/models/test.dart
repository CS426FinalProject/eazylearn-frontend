import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/constants/colors.dart';
import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:flutter/material.dart';

class Test {
  String testID;
  String name;
  int time;
  String description;
  Color color;
  String subject;
  List<Topic> topics;
  List<Question> questions;
  Test(
      {@required this.testID,
      @required this.name,
      @required this.time,
      @required this.subject,
      @required this.topics,
      @required this.description,
      @required this.questions}) {
    color = mapColors[subject];
  }

  static Future<Test> fromJson(Map json) async {
    Iterable topicIDs = json["topicId"];
    Iterable q = json["questions"];
    List<Topic> topics = [];
    List<Question> questions = [];
    for (String id in topicIDs) {
      Topic tmp = await API.getTopicByID(id);
      topics.add(tmp);
    }
    print("return");
    questions = List.of(q.map((e) => Question.fromJson(e)).toList());

    return Test(
        testID: json["testId"].toString(),
        name: json["name"].toString(),
        time: 30,
        subject: json["subject"].toString(),
        topics: topics,
        description: "description",
        questions: questions);
  }
}
