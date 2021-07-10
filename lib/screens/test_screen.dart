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
          child: Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'CALCULUS III',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Card(
                      color: top_icon_2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text('10:00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: Colors.transparent),
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
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'f(x,y) = 2x^3 + y^4\nD = {(x,y) | x^2 + y^2 <= 1}',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 21.0,
                  ),
                  AnswerCard(
                    answer: Answer(answerText: 'A. min(f) = 12, max(f) = 14'),
                  ),
                  AnswerCard(
                    answer: Answer(answerText: 'B. min(f) = -8, max(f) = 24'),
                  ),
                  AnswerCard(
                    answer: Answer(answerText: 'C. min(f) = 1, max(f) = 12'),
                  ),
                  AnswerCard(
                    answer: Answer(answerText: 'D. min(f) = -12, max(f) = 14'),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
