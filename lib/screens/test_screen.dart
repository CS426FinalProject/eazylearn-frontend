import 'dart:ui';

import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/utility/answer_chooser.dart';
import 'package:final_cs426/utility/question_wheel.dart';
import 'package:flutter/material.dart';
import 'package:final_cs426/models/answer.dart';
import 'package:final_cs426/constants/color.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool byScroll = false;
  PageController pageController = PageController();
  PageController wheelController;
  ValueNotifier<double> notifier = ValueNotifier(0);
  int currentQuestion;
  Test test;
  List<int> userChoices;
  @override
  void initState() {
    super.initState();
    currentQuestion = 0;
    List<Answer> options = [
      Answer(answerText: "min(f) = 12, max(f) = 14"),
      Answer(answerText: "min(f) = -8, max(f) = 24"),
      Answer(answerText: "min(f) = 1, max(f) = 12"),
      Answer(answerText: "min(f) = -12, max(f) = 14")
    ];
    List<Question> questions = List.generate(
        40,
        (index) => Question(
            question:
                '${index + 1}: What are the extreme values of the function f on the given region?',
            equation:
                '${index + 1}: f(x,y) = 2x^3 + y^4\nD = {(x,y) | x^2 + y^2 <= 1}',
            options: options,
            answer: 1));
    test = Test(idTest: "1", topic: "Calculus", questions: questions);
    userChoices = List.generate(test.questions.length, (index) => -1);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
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
              color: timerColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text('10:00',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Column(
          children: <Widget>[
            QuestionWheel(
              onControllerCreated: (controller) => wheelController = controller,
              questionNumber: test.questions.length,
              onScroll: (value) {
                setState(() {
                  pageController.animateTo(value * (width - 40),
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                  byScroll = true;
                });
              },
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) => setState(() {
                  currentQuestion = index;
                  if (!byScroll) wheelController.jumpToPage(index);
                  byScroll = false;
                }),
                itemBuilder: (context, index) => Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                            child: Column(
                              children: [
                                Text(
                                  test.questions[index].question,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  test.questions[index].equation,
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
                          AnswerChooser(
                            initial: userChoices[index],
                            options: test.questions[index].options,
                            onOptionChange: (option) {
                              setState(() {
                                userChoices[index] = option;
                              });
                            },
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
 
          
 */
