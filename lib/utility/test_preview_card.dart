import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/test_preview.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:flutter/material.dart';

class TestPreviewCard extends StatelessWidget {
  final TestPreview preview;
  final bool isFirst;
  final bool isInTestChoosingScreen;
  const TestPreviewCard(
      {@required this.preview,
      @required this.isFirst,
      @required this.isInTestChoosingScreen});
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
        margin: EdgeInsets.fromLTRB(
          isInTestChoosingScreen ? 0 : (isFirst ? 35 : 15),
          isInTestChoosingScreen && isFirst ? 20 : 0,
          0,
          0,
        ),
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
                    height: !isInTestChoosingScreen ? 200 : 60,
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
                          preview.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        !isInTestChoosingScreen
                            ? SizedBox(
                                height: 10,
                              )
                            : SizedBox.shrink(),
                        !isInTestChoosingScreen
                            ? Text(
                                preview.subject.name,
                                style: Theme.of(context).textTheme.subtitle1,
                              )
                            : SizedBox.shrink(),
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
    String displayedTopics = "";
    for (Topic topic in preview.topics) {
      displayedTopics += topic.name + ", ";
    }
    displayedTopics = displayedTopics.trim() + "...";
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      height: 600,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(children: [
              SizedBox(
                width: 60,
                child: Divider(
                  thickness: 3,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 5),
              Text(
                preview.name,
                style: Theme.of(context).textTheme.headline5.copyWith(
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Subject",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    preview.subject.name,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(width: 5),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: preview.color),
                                    child: SizedBox(width: 20, height: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Time",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(height: 5),
                              Text(preview.time.toString() + " min",
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .bodyText1)
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Topic",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      displayedTopics,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
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
                          "bla bla bla bla bla bla bla bla bla " +
                          "bla bla bla bla bla bla bla bla bla " +
                          "bla bla bla bla bla bla bla bla bla " +
                          "bla bla bla bla bla bla bla bla bla\n\nbla\nbla\nbla\nbla\nbla ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 15, right: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TestScreen()));
              },
              child: Text(
                "START",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 70)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
