import 'package:final_cs426/constants/color.dart';
import 'package:flutter/material.dart';

class QuestionWheel extends StatefulWidget {
  final ValueChanged<double> onScroll;
  final ValueChanged<PageController> onControllerCreated;
  final int questionNumber;
  QuestionWheel(
      {@required this.onScroll,
      @required this.onControllerCreated,
      @required this.questionNumber});
  @override
  _QuestionWheelState createState() => _QuestionWheelState();
}

class _QuestionWheelState extends State<QuestionWheel> {
  PageController _controller;
  int selected = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 1 / 3,
    )..addListener(() {
        print("haiya");
        widget.onScroll(_controller.page);
      });
    widget.onControllerCreated(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(color: primaryColor),
      child: PageView.builder(
          onPageChanged: (index) {
            setState(() {
              selected = index;
            });
          },
          itemCount: widget.questionNumber,
          controller: _controller,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.animateToPage(index,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.ease);
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == selected
                          ? timerColor
                          : (Colors.white
                              .withOpacity(1 - abs(index - selected) / 10))),
                  child: Center(child: Text("${index + 1}")),
                ),
              )),
    );
  }

  int abs(int a) {
    return a > 0 ? a : -a;
  }
}
