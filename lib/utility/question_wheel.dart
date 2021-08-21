import 'package:final_cs426/constants/color.dart';
import 'package:flutter/material.dart';

class QuestionWheel extends StatefulWidget {
  final ValueChanged<double> onScroll;
  final ValueChanged<PageController> onControllerCreated;
  final int questionNumber;
  final List<int> userChoices;
  final ValueChanged<int> onQuestionChosenByPicker;
  QuestionWheel(
      {@required this.onScroll,
      @required this.onControllerCreated,
      @required this.questionNumber,
      @required this.userChoices,
      @required this.onQuestionChosenByPicker});
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
                onTap: () async {
                  if (selected != index)
                    setState(() {
                      _controller.animateToPage(index,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.ease);
                    });
                  else {
                    int chosen = await showDialog(
                            context: context,
                            builder: (context) => _buildQuestionPicker()) ??
                        selected;
                    widget.onQuestionChosenByPicker(chosen);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(
                          positive(1 - abs(index - selected) * 2 / 10))),
                  child: Center(child: Text("${index + 1}")),
                ),
              )),
    );
  }

  int abs(int a) {
    return a > 0 ? a : -a;
  }

  double positive(double a) {
    return a <= 0 ? 0 : a;
  }

  Widget _buildQuestionPicker() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        height: 500,
        width: double.infinity,
        child: GridView.builder(
            itemCount: widget.questionNumber,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("before setting state");
                  Navigator.pop(context, index);
                },
                child: Center(
                    child: Container(
                  margin: EdgeInsets.all(5),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: !((selected == index) ||
                              (widget.userChoices[index] != -1))
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                      color: selected == index
                          ? secondaryColor
                          : (widget.userChoices[index] != -1
                              ? primaryColor
                              : Colors.white)),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: (widget.userChoices[index] != -1)
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                )),
              );
            }),
      ),
    );
  }
}
