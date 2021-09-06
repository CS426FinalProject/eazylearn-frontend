import 'package:flutter/material.dart';

class Topic {
  String topicID;
  String name;
  Topic({@required this.topicID, @required this.name});
  factory Topic.fromJson(Map json) {
    return Topic(topicID: json['topicId'], name: json['name']);
  }
}
