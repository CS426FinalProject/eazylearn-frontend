import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/controller/question_picker_controller.dart';
import 'package:flutter/material.dart';

class QuestionPicker extends StatefulWidget {
  final QuestionPickerController controller;
  final ValueChanged<int> onQuestionChanged;
  final List<int> userChoices;
  final int currentQuestion;
  const QuestionPicker({
    @required this.onQuestionChanged,
    @required this.userChoices,
    @required this.currentQuestion,
    @required this.controller,
  });
  @override
  _QuestionPickerState createState() => _QuestionPickerState();
}

class _QuestionPickerState extends State<QuestionPicker> {
  bool isDropdown = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        isDropdown = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
            duration: Duration(milliseconds: 700),
            curve: Curves.ease,
            decoration: BoxDecoration(
              borderRadius: isDropdown
                  ? null
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
              color: secondaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print(isDropdown);
                  setState(() {
                    isDropdown = !isDropdown;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "${widget.currentQuestion + 1}/${widget.userChoices.length}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20.0),
        child: AnimatedContainer(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            duration: Duration(milliseconds: 700),
            curve: Curves.fastLinearToSlowEaseIn,
            height: isDropdown ? 500 : 0,
            alignment:
                isDropdown ? Alignment.center : AlignmentDirectional.topCenter,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, mainAxisSpacing: 5, crossAxisSpacing: 5),
                itemCount: widget.userChoices.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () => setState(() {
                            isDropdown = false;
                            widget.onQuestionChanged(index);
                          }),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: index == widget.currentQuestion
                                      ? Colors.black
                                      : (widget.userChoices[index] != -1
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: (index == widget.currentQuestion ||
                                widget.userChoices[index] != -1)
                            ? Border()
                            : Border.all(color: Colors.black, width: 2.0),
                        color: index == widget.currentQuestion
                            ? secondaryColor
                            : (widget.userChoices[index] == -1
                                ? Colors.white
                                : primaryColor),
                        borderRadius: BorderRadius.circular(100)),
                  );
                })),
      )
    ]);
  }
}
