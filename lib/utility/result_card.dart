import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/question.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class ResultCard extends StatefulWidget {
  final int index;
  final Question question;
  final int answer;

  ResultCard(
      {@required this.index, @required this.question, @required this.answer});
  @override
  _ResultCardState createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool isExpanding = false;
  bool isCorrect;
  bool isMissing;
  @override
  void initState() {
    super.initState();
    isMissing = widget.answer == -1;
    isCorrect = !isMissing &&
        (widget.question.options[widget.answer] == widget.question.answer);
  }

  @override
  Widget build(BuildContext context) {
    String explanation = "";
    for (int i = 0; i < widget.index; i++) {
      explanation += "test\n";
    }
    return Theme(
      data: ThemeData(fontFamily: "Open Sans"),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
                color: isMissing ? missed : (isCorrect ? correct : incorrect))),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  widget.index.toString(),
                  style: TextStyle(
                      color: isMissing
                          ? missed
                          : (isCorrect ? correct : incorrect),
                      fontSize: 25),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      useInkWell: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center),
                  header: Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                      widget.answer == -1
                          ? "(You missed this one)"
                          : widget.question.options[widget.answer],
                      style: TextStyle(
                          fontSize: 20, color: isCorrect ? correct : incorrect),
                    ),
                  ),
                  collapsed: SizedBox.shrink(),
                  expanded:
                      Text(explanation, style: TextStyle(color: Colors.black))),
            ),
          ],
        ),
      ),
    );
  }
}



/*
AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isExpanding ? 240 : 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              decoration: BoxDecoration(
                  color: widget.question.answer == widget.answer
                      ? correct
                      : incorrect,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: Center(
                child: Text(
                  "${widget.index}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(15, 33, 10, 33),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.question.options[widget.question.answer]
                            .answerText,
                        style: TextStyle(
                            fontSize: 20,
                            color: widget.question.answer == widget.answer
                                ? correct
                                : incorrect),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Container(
                          child: Text(
                            widget.question.explanation,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ))
                    ]),
              ),
            )),
            IconButton(
                onPressed: () => setState(() => isExpanding = !isExpanding),
                icon: Icon(isExpanding
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down))
          ],
        ),
      ),
    );
*/