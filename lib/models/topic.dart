import 'package:flutter/material.dart';

class Topic {
  String name;
  int time;
  int difficulty;
  String image;
  List<Color> colors;
  Topic(
      {@required this.name,
      @required this.time,
      @required this.difficulty,
      @required this.colors}) {
    image = name;
    image = image.replaceAll(' ', '_');
    image = image.toLowerCase();
    // lib\images\topic_icons\calculus_iii.png
    image = "lib/images/topic_icons/" + image + ".png";
    print(image);
  }
}
