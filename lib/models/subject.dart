import 'package:final_cs426/models/topic.dart';
import 'package:flutter/material.dart';

class Subject {
  String name;
  String image;
  Color color;
  List<Topic> topics;
  Subject({@required this.name, @required this.color, @required this.topics}) {
    image = name;
    image = image.replaceAll(' ', '_');
    image = image.toLowerCase();
    image = "lib/images/topic_icons/" + image + ".png";
    print(image);
  }
}
