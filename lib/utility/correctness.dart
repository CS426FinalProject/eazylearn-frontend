import 'package:final_cs426/constants/color.dart';
import 'package:flutter/material.dart';

class Correctness extends StatelessWidget {
  final List<bool> corrects;
  Correctness({@required this.corrects});
  @override
  Widget build(BuildContext context) {
    print("go");
    List<int> flex = [];
    List<Expanded> expandeds = [];
    bool isCorrectFirst = corrects[0];
    int count = 0;
    for (int i = 0; i < corrects.length - 1; i++) {
      if (corrects[i] == corrects[i + 1]) {
        count++;
      } else {
        flex.add(++count);
        count = 0;
      }
    }
    flex.add(count + 1);
    for (int i in flex) {
      expandeds.add(Expanded(
        flex: i,
        child: DecoratedBox(
          decoration:
              BoxDecoration(color: isCorrectFirst ? correct : incorrect),
          child: SizedBox(
            height: 50,
          ),
        ),
      ));
      isCorrectFirst = !isCorrectFirst;
    }
    return Row(
      children: expandeds,
    );
  }
}
