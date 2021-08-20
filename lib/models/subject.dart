import 'package:flutter/material.dart';

class Subject {
  String name;
  String image;
  Color color;
  Subject({@required this.name, @required this.color}) {
    image = name;
    image = image.replaceAll(' ', '_');
    image = image.toLowerCase();
    image = "lib/images/topic_icons/" + image + ".png";
    print(image);
  }
}
