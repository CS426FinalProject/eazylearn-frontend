import 'dart:math';

import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/colors.dart';
import 'package:final_cs426/models/answer.dart';
import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/routes/routes.dart';
import 'package:final_cs426/screens/all_answer_screen.dart';
import 'package:final_cs426/utility/correctness.dart';
import 'package:final_cs426/utility/result_circle.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int> answers;
  ResultScreen({@required this.questions, @required this.answers});

  @override
  Widget build(BuildContext context) {
    List<bool> corrects = List.generate(
        questions.length, (index) => questions[index].answer == answers[index]);
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, ModalRoute.withName(Routes.home));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "MATHEMATICS",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            physics: BouncingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Outstanding".toUpperCase(),
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: kEzLearnCorrectGreen,
                        fontSize: 48,
                      ),
                ),
              ),
              ResultCircle(questionCount: 30, corrects: 24),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2)),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(Icons.timer, size: 35),
                        SizedBox(width: 5),
                        Text(
                          "16min 48s",
                          style: Theme.of(context)
                              .accentTextTheme
                              .headline6
                              .copyWith(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Correctness",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 5),
              Correctness(corrects: corrects),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.07)),
                    ),
                    child: Text(
                      "Show all answer",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: kEzLearnGrey,
                          ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllAnswerScreen(
                                questions: questions,
                                answers: answers,
                              )));
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.surface),
                              minimumSize:
                                  MaterialStateProperty.all(Size(60, 60)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () {},
                          child: Icon(
                            Icons.share,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 30,
                          )),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
