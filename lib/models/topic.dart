import 'package:flutter/material.dart';

class Topic {
  String name;
  int time;
  int difficulty;
  String image;
  String description;
  List<Color> colors;
  Topic(
      {@required this.name,
      @required this.description,
      @required this.time,
      @required this.difficulty,
      @required this.colors}) {
    image = name;
    image = image.replaceAll(' ', '_');
    image = image.toLowerCase();
    image = "lib/images/topic_icons/" + image + ".png";
    print(image);
  }
}
