import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:final_cs426/models/answer.dart';
import 'package:final_cs426/utility/answer_card.dart';
import 'package:final_cs426/constants/color.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[cal1, cal2])),
          child: Scaffold(backgroundColor: Colors.transparent),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 76.0, 20.0, 0),
          child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Column(
                          children: [
                            Text(
                              'What are the extreme values of the function f on the given region?',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                                'f(x,y) = 2x^3 + y^4, D = {(x,y) | x^2 + y^2 <= 1}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 21.0,
                      ),
                      AnswerCard(
                        answer:
                            Answer(answerText: 'A. min(f) = 12, max(f) = 14'),
                      ),
                      AnswerCard(
                        answer: Answer(
                            answerText: 'B. min(f) = -8, max(f) = 24',
                            chosen: true),
                      ),
                      AnswerCard(
                        answer:
                            Answer(answerText: 'C. min(f) = 1, max(f) = 12'),
                      ),
                      AnswerCard(
                        answer:
                            Answer(answerText: 'D. min(f) = -12, max(f) = 14'),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
