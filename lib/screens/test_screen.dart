import 'dart:async';
import 'dart:ui';

import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/models/result.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/routes/routes.dart';
import 'package:final_cs426/screens/result_screen.dart';
import 'package:final_cs426/utility/answer_chooser.dart';
import 'package:final_cs426/utility/current_question_tracker.dart';
import 'package:final_cs426/utility/question_wheel.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  final Test test;
  TestScreen({@required this.test});
  @override
  _TestScreenState createState() => _TestScreenState();
}

bool init = true;
bool initScreen = true;
int _timeLeft;
DateTime _timeStart;
Timer _timer;

class _TestScreenState extends State<TestScreen> {
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
    test = widget.test;
    userChoices = List.generate(test.questions.length, (index) => -1);
    if (init) {
      _timeStart = DateTime.now();
      _timeLeft = test.time * 60 + 1;
      _startTimer();
      init = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print(init);
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        initScreen = false;
        print("asdfasdfasfasdfasdfasdf");
      });
    });
    currentQuestion = 0;
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
    wheelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        child: initScreen
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
                    init = true;
                    initScreen = true;
                    _timer.cancel();
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
                    test.name,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestCard(int index) {
    return GestureDetector(
      onPanUpdate: (detail) {
        if (detail.delta.dy < 0) {
          Navigator.of(context).push(CustomRouteBuilder(
              first: TestScreen(
                test: test,
              ),
              second: SubmitScreen(
                test: test,
                userChoices: userChoices,
              )));
        }
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
                    if (test.questions[index].requirement != null &&
                        test.questions[index].requirement.isNotEmpty)
                      Text(
                        test.questions[index].requirement,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontSize: 18, letterSpacing: 0),
                      ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (test.questions[index].content != null &&
                        test.questions[index].content.isNotEmpty)
                      Text(
                        test.questions[index].content,
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                questions: test.questions,
                answers: userChoices,
                time: test.time * 60 - _timeLeft,
              ),
            ),
          );
        } else {
          setState(() {
            print(_timeLeft);
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
  SubmitScreen({
    @required this.test,
    @required this.userChoices,
  });
  Future _onSubmitClicked(BuildContext context) async {
    init = true;
    initScreen = true;
    _timer.cancel();

    List<String> userChoicesStrings = [];
    for (int i = 0; i < userChoices.length; i++) {
      if (userChoices[i] != -1)
        userChoicesStrings.add(test.questions[i].options[userChoices[i]]);
      else
        userChoicesStrings.add("");
    }
    Result result = Result(
        userID: Session.userID,
        test: test,
        answer: userChoicesStrings,
        timeStart: _timeStart,
        timeEnd: DateTime.now());

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ResultScreen(
        result: result,
        isFromTest: true,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (detail) {
        if (detail.delta.dy > 0) Navigator.pop(context);
      },
      child: Scaffold(
          key: ValueKey("SUBMIT"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _onSubmitClicked(context);
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
                SizedBox(height: 10),
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.07),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ))
              ],
            ),
          )),
    );
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
