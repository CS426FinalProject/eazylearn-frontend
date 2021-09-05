import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:flutter/material.dart';

class Subject {
  String subjectID;
  String name;
  String image;
  Color color;
  Subject(
      {@required this.subjectID, @required this.name, @required this.color}) {
    image = name;
    image = image.replaceAll(' ', '_');
    image = image.toLowerCase();
    image = "lib/images/topic_icons/" + image + ".png";
    print(image);
  }

  factory Subject.fromJson(Map json, int index) {
    return Subject(
        subjectID: json['subjectId'], name: json['name'], color: colors[index]);
  }
}
