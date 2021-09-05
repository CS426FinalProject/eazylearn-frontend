import 'dart:async';
import 'dart:ui';

import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/routes/routes.dart';
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

bool init = true;

class _TestScreenState extends State<TestScreen> {
  Timer _timer;
  int _timeLeft;

  bool locked = false;
  bool submit = false;
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
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        child: init
            ? Scaffold(
                key: ValueKey("SPLASH"),
                backgroundColor: Theme.of(context).colorScheme.primary,
                body: Center(
                  child: Text(
                    "EazyLearn".toUpperCase(),
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontSize: 48,
                        ),
                  ),
                ),
              )
            : _buildTestScreen());
  }

  Widget _buildTestScreen() {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("Quit so soon?"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(Routes.home));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    overlayColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.07)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  child: Text(
                    "Confirm",
                    style: Theme.of(context).accentTextTheme.headline6,
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).accentTextTheme.headline6,
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onSurface),
                    overlayColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.07)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                  ),
                )
              ],
            ),
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        key: ValueKey("TEST"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'MATHEMATICS',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
                            style: Theme.of(context)
                                .accentTextTheme
                                .headline5
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary)),
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
                    key: ValueKey("bla"),
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
                    itemBuilder: (context, index) => _buildTestCard(index)),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // ElevatedButton(
              //   onPressed: () => _onSubmitClicked(),
              //   child: Text(
              //     "Submit",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20),
              //   ),
              //   style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all(secondaryColor),
              //       minimumSize: MaterialStateProperty.all(Size(200, 50)),
              //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(18)))),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestCard(int index) {
    return GestureDetector(
      onPanUpdate: (detail) {
        if (detail.delta.dy < 0)
          Navigator.of(context).push(CustomRouteBuilder(
              first: TestScreen(),
              second: SubmitScreen(
                test: test,
                userChoices: userChoices,
              )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Column(
                  children: [
                    Text(
                      test.questions[index].question,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontSize: 18, letterSpacing: 0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      test.questions[index].equation,
                      style: Theme.of(context)
                          .accentTextTheme
                          .bodyText1
                          .copyWith(fontStyle: FontStyle.italic),
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
      ),
    );
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

class SubmitScreen extends StatelessWidget {
  final Test test;
  final List<int> userChoices;
  SubmitScreen({@required this.test, @required this.userChoices});
  void _onSubmitClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResultScreen(
              questions: test.questions,
              answers: userChoices,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: ValueKey("SUBMIT"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 174,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    _onSubmitClicked(context);
                  },
                  child: Text(
                    "Submit",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.07))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ))
            ],
          ),
        ));
  }
}

class CustomRouteBuilder extends PageRouteBuilder {
  final Widget first;
  final Widget second;
  CustomRouteBuilder({@required this.first, @required this.second})
      : super(
            pageBuilder: (_, __, ___) => second,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return Stack(
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.0),
                      end: const Offset(0.0, -1.0),
                    ).animate(
                      CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeIn,
                          reverseCurve: Curves.easeOut),
                    ),
                    child: first,
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeIn,
                          reverseCurve: Curves.easeOut),
                    ),
                    child: second,
                  )
                ],
              );
            });
}
