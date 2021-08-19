import 'package:final_cs426/models/test_preview.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:flutter/material.dart';

class TestPreviewCard extends StatelessWidget {
  final TestPreview preview;
  final bool isFirst;
  const TestPreviewCard({@required this.preview, @required this.isFirst});
  @override
  Widget build(BuildContext context) {
    List<Image> difficultyDisplayer = [];
    for (int i = 0; i < preview.difficulty; i++) {
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
        margin: EdgeInsets.only(left: isFirst ? 35 : 15),
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
                        color: preview.color,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    padding: EdgeInsets.all(15),
                    height: 120,
                    width: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(preview.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.timer),
                            Text("${preview.time} min"),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: difficultyDisplayer,
                            ))
                          ],
                        )
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

  Widget _buildSheet(BuildContext context) {
    List<Image> difficultyDisplayer = [];
    for (int i = 0; i < preview.difficulty; i++) {
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
                color: preview.color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Text(
              preview.name,
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
                        "Time:\n${preview.time} min",
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
                  backgroundColor: MaterialStateProperty.all(preview.color),
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
