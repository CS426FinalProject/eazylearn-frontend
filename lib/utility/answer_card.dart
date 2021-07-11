import 'dart:ui';

import 'package:final_cs426/models/answer.dart';
import 'package:flutter/material.dart';
import 'package:final_cs426/constants/color.dart';

class AnswerCard extends StatelessWidget {
  final Answer answer;
  final bool chosen;
  const AnswerCard({@required this.answer, @required this.chosen});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: DecoratedBox(
            decoration: BoxDecoration(
              border: !chosen
                  ? Border.all(color: Colors.black, width: 1.0)
                  : Border(),
              borderRadius: BorderRadius.circular(20.0),
              color: chosen ? Colors.white : Colors.transparent,
              gradient: LinearGradient(colors: <Color>[cal1, cal2]),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(answer.answerText,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: !chosen ? Colors.black : Colors.white)),
                ],
              ),
            )));
  }
}
