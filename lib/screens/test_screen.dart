import 'dart:async';
import 'dart:ui';

import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/screens/result_screen.dart';
import 'package:final_cs426/utility/answer_chooser.dart';
import 'package:final_cs426/utility/current_question_tracker.dart';
import 'package:final_cs426/utility/question_wheel.dart';
import 'package:flutter/material.dart';
import 'package:final_cs426/models/answer.dart';
import 'package:final_cs426/constants/color.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Timer _timer;
  int _timeLeft;

  bool init = true;
  bool locked = false;
  PageController pageController = PageController();
  PageController wheelController;
  int currentQuestion;
  Test test;
  List<int> userChoices;
  @override
  void initState() {
    super.initState();

    _timeLeft = 40 * 60;

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
            answer: 1,
            explanation:
                'Explanation ${index + 1}: f(x,y) = 2x^3 + y^4\nasdfasdfasdfasdfasdfasd fasdfasdfasdfasdfasd fasdfasdfasdf asdfasdfasdf asdfasdfasdfa sdfasdfa sdfasdfasdfasdfasdfs'));
    test = Test(idTest: "1", topic: "Calculus", questions: questions);
    userChoices = List.generate(test.questions.length, (index) => -1);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        init = false;
        _startTimer();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    pageController.dispose();
    wheelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      child: init
          ? Scaffold(
              key: ValueKey("SPLASH"),
              backgroundColor: primaryColor,
              body: Center(
                child: Text(
                  "MATHEMATICS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Scaffold(
              key: ValueKey("TEST"),
              backgroundColor: primaryColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'MATHEMATICS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
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
                              Text('${_toMinute(_timeLeft)}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Open Sans",
                                      fontSize: 22,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          )),
                    ),
                  ],
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          CurrentQuestionTracker(
                              questionNumber: test.questions.length,
                              selected: currentQuestion),
                          SizedBox(
                            height: 10,
                          ),
                          QuestionWheel(
                            onControllerCreated: (controller) =>
                                wheelController = controller,
                            questionNumber: test.questions.length,
                            userChoices: userChoices,
                            onScroll: (value) {
                              setState(() {
                                if (!locked) {
                                  locked = true;
                                  pageController.animateTo(value * (width),
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                  locked = false;
                                }
                              });
                            },
                            onQuestionChosenByPicker: (value) {
                              setState(() {
                                currentQuestion = value;
                                pageController.jumpToPage(value);
                                wheelController.jumpToPage(value);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                          itemCount: test.questions.length,
                          controller: pageController,
                          onPageChanged: (index) => setState(() {
                                if (!locked) {
                                  currentQuestion = index;
                                  locked = true;
                                  wheelController.jumpToPage(index);
                                  locked = false;
                                }
                              }),
                          itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 70, 20, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 8.0, 0),
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
                                                fontFamily: "Open Sans",
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
                                ),
                              )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _onSubmitClicked(),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(secondaryColor),
                          minimumSize: MaterialStateProperty.all(Size(200, 50)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)))),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void _onSubmitClicked() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResultScreen(
              questions: test.questions,
              answers: userChoices,
            )));
  }

  void _startTimer() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (_timeLeft == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _timeLeft--;
          });
        }
      },
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
