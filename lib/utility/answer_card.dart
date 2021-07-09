import 'dart:ui';

import 'package:final_cs426/models/answer.dart';
import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  final Answer answer;

  const AnswerCard({@required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  answer.chosen = !answer.chosen;
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(answer.answerText,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ))));
  }
}
