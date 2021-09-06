import 'package:final_cs426/models/question.dart';
import 'package:final_cs426/utility/result_card.dart';
import 'package:flutter/material.dart';

class AllAnswerScreen extends StatelessWidget {
  final String testName;
  final List<Question> questions;
  final List<String> answers;
  AllAnswerScreen(
      {@required this.questions,
      @required this.answers,
      @required this.testName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          testName,
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontSize: 36,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(Icons.arrow_back),
                  iconSize: 34.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  'All answers',
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                itemBuilder: (context, index) => ResultCard(
                    index: index + 1,
                    question: questions[index],
                    answer: answers[index]),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: questions.length),
          ),
        ],
      ),
    );
  }
}
