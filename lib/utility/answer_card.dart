import 'dart:ui';

import 'package:final_cs426/models/answer.dart';
import 'package:flutter/material.dart';
import 'package:final_cs426/constants/color.dart';

class AnswerCard extends StatefulWidget {
  final Answer answer;

  const AnswerCard({@required this.answer});

  @override
  _AnswerCardState createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: DecoratedBox(
            decoration: BoxDecoration(
              border: !widget.answer.chosen
                  ? Border.all(color: Colors.black, width: 1.0)
                  : Border(),
              borderRadius: BorderRadius.circular(20.0),
              color: widget.answer.chosen ? Colors.white : Colors.transparent,
              gradient: LinearGradient(colors: <Color>[cal1, cal2]),
            ),
            child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: _handleTap,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.answer.answerText,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: !widget.answer.chosen
                                  ? Colors.black
                                  : Colors.white)),
                    ],
                  ),
                ))));
  }

  void _handleTap() {
    setState(() {
      widget.answer.chosen = !widget.answer.chosen;
    });
  }
}
