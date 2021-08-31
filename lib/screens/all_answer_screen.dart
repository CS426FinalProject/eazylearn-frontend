import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/utility/result_card.dart';
import 'package:flutter/material.dart';

class AllAnswerScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int> answers;
  AllAnswerScreen({@required this.questions, @required this.answers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "MATHEMATICS",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: ListView.separated(
            itemBuilder: (context, index) => ResultCard(
                index: index + 1,
                question: questions[index],
                answer: answers[index]),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: questions.length),
      ),
    );
  }
}
