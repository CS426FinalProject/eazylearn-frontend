import 'dart:math';

import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/routes/routes.dart';
import 'package:final_cs426/screens/all_answer_screen.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:final_cs426/utility/correctness.dart';
import 'package:final_cs426/utility/result_circle.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int> answers;
  final int time;
  ResultScreen(
      {@required this.questions, @required this.answers, @required this.time});

  @override
  Widget build(BuildContext context) {
    init = true;
    print(init);
    List<bool> corrects = List.generate(
        questions.length,
        (index) => (answers[index] != -1 &&
            questions[index].answer ==
                questions[index].options[answers[index]]));
    int correctCount = 0;
    for (bool b in corrects) if (b) correctCount++;
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, ModalRoute.withName(Routes.home));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "MATHEMATICS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Column(
            children: [
              Text(
                "Your result",
                style: TextStyle(
                    color: correct, fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              ResultCircle(
                  questionCount: questions.length, corrects: correctCount),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all()),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.timer, size: 35),
                    SizedBox(width: 5),
                    Text(
                      _toMinute(time),
                      style: TextStyle(fontFamily: "Open Sans", fontSize: 30),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Correctness", style: TextStyle(fontSize: 20))),
              SizedBox(height: 5),
              Correctness(corrects: corrects),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        overlayColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(0.07))),
                    child: Text("Show all answer",
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllAnswerScreen(
                                questions: questions,
                                answers: answers,
                              )));
                    },
                  )),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(secondaryColor),
                          minimumSize: MaterialStateProperty.all(Size(300, 60)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName(Routes.home));
                      },
                      child: Text("Done",
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              color: Colors.black,
                              fontSize: 25))),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            minimumSize:
                                MaterialStateProperty.all(Size(60, 60)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        onPressed: () {},
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 30,
                        )),
                  ))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  String _toMinute(int sec) {
    String minute = (sec ~/ 60).toString();
    String second = (sec % 60).toString();
    if (minute.length == 1) minute = "0" + minute;
    if (second.length == 1) second = "0" + second;
    return "$minute:$second";
  }
}
