import 'package:flutter/material.dart';

import 'answer_card.dart';

class AnswerChooser extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int> onOptionChange;
  final int initial;
  const AnswerChooser(
      {@required this.options,
      @required this.onOptionChange,
      @required this.initial});
  @override
  _AnswerChooserState createState() => _AnswerChooserState();
}

class _AnswerChooserState extends State<AnswerChooser> {
  List<bool> chosens;
  @override
  void initState() {
    super.initState();
    chosens = List.generate(4, (index) => widget.initial == index);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => _handleTap(index),
                child: AnswerCard(
                  chosen: chosens[index],
                  answer:
                      '${String.fromCharCode(65 + index)}. ${widget.options[index]}',
                ),
              ),
          separatorBuilder: (index, context) => SizedBox(
                height: 10,
              ),
          itemCount: widget.options.length),
    );
  }

  void _handleTap(int index) {
    setState(() {
      for (int i = 0; i < 4; i++) {
        if (i == index) {
          chosens[i] = true;
          widget.onOptionChange(i);
        } else
          chosens[i] = false;
      }
    });
  }
}
