import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/result.dart';
import 'package:final_cs426/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final Result result;
  HistoryCard({@required this.result});
  @override
  Widget build(BuildContext context) {
    String score;
    String dayTaken = DateFormat("dd/MM/yyyy").format(result.timeStart);
    int count = 0;
    for (int i = 0; i < result.answer.length; i++) {
      if (result.answer[i] == result.test.questions[i].answer) count++;
    }
    score = count.toString() + "/" + result.answer.length.toString();
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ResultScreen(isFromTest: false, result: result)));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: mapColors[result.test.subject],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    padding: EdgeInsets.all(15),
                    height: 150,
                    width: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          result.test.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          result.test.subject,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          score,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          dayTaken,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
