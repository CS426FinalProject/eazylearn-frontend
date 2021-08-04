import 'package:flutter/material.dart';

class CurrentQuestionTracker extends StatelessWidget {
  final int questionNumber;
  final int selected;

  const CurrentQuestionTracker(
      {@required this.questionNumber, @required this.selected});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < questionNumber; i++) {
      widgets.add(Expanded(
        flex: selected == i ? 4 : 1,
        child: Container(
          height: 7,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(selected == i ? 1 : 0.7)),
        ),
      ));
      if (i + 1 != questionNumber)
        widgets.add(SizedBox(
          width: 3,
        ));
    }
    return Row(
      children: widgets,
    );
  }
}
