import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/screens/test_info_screen.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;

  const TopicCard({@required this.topic});
  @override
  Widget build(BuildContext context) {
    List<Image> difficultyDisplayer = [];
    for (int i = 0; i < topic.difficulty; i++) {
      difficultyDisplayer.add(Image.asset(
        "lib/images/flash.png",
        scale: 25,
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(left: 15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) => _buildSheet(context));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: topic.color,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(15),
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          topic.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(topic.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            topic.time.toString() + " min",
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Row(
                            children: difficultyDisplayer,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSheet(BuildContext context) {
    List<Image> difficultyDisplayer = [];
    for (int i = 0; i < topic.difficulty; i++) {
      difficultyDisplayer.add(Image.asset(
        "lib/images/flash.png",
        scale: 25,
      ));
    }
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      height: 600,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: topic.color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Text(
              topic.name,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          //decoration: BoxDecoration(color: Colors.blue),
                          child: Text(
                        "Time:\n${topic.time} min",
                        style: TextStyle(fontSize: 20),
                      )),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // decoration: BoxDecoration(color: Colors.red),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Difficulty",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: difficultyDisplayer,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Description\n" +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla " +
                      "bla bla bla bla bla bla bla bla bla ",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TestScreen()));
              },
              child: Text(
                "START",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(topic.color),
                  minimumSize: MaterialStateProperty.all(Size(270, 50)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)))),
            ),
          ))
        ],
      ),
    );
  }
}
