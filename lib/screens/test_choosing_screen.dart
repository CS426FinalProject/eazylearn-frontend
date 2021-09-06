import 'dart:ui';

import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/colors.dart';
import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/utility/test_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestChoosingScreen extends StatefulWidget {
  final Subject subject;
  TestChoosingScreen({@required this.subject});
  @override
  _TestChoosingScreenState createState() => _TestChoosingScreenState();
}

class _TestChoosingScreenState extends State<TestChoosingScreen> {
  FocusNode inputFocusNode = FocusNode();
  Subject subject;
  List<Test> previews = [];
  List<Topic> topics;
  List<bool> topicsChecked;
  bool isLoaded = false;
  Future getTopics() async {
    topics = await API.getAllTopicBySubject(widget.subject.subjectID, context);
    if (topics != null) {
      topicsChecked = List.generate(topics.length, (index) => false);
      List<String> topicIDs = [];
      for (Topic topic in topics) {
        topicIDs.add(topic.topicID);
      }
      previews = await API.getTestByTopicIDs(topicIDs, context);

      if (previews != null)
        setState(() {
          isLoaded = true;
        });
    }
  }

  @override
  void initState() {
    super.initState();
    subject = widget.subject;
    getTopics();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded)
      return Scaffold(
          body: Center(child: CircularProgressIndicator(color: primaryColor)));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 75,
        title: Text(
          subject.name.toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          iconSize: 30,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndFilterBar(),
          _buildListTest(),
        ],
      ),
    );
  }

  _buildSearchAndFilterBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      spreadRadius: 10,
                      color: Color(0x6D8DAD).withOpacity(0.25),
                    )
                  ]),
              child: TextFormField(
                style: Theme.of(context).textTheme.headline6,
                focusNode: inputFocusNode,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search",
                  focusColor: Theme.of(context).colorScheme.primary,
                  border: InputBorder.none,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      spreadRadius: 10,
                      color: Color(0x6D8DAD).withOpacity(0.25))
                ]),
            child: IconButton(
                iconSize: 40,
                onPressed: () async {
                  bool apply = await showDialog(
                      context: context,
                      builder: (context) => TopicCheckboxDialog(
                            topicsChecked: topicsChecked,
                            topics: topics,
                          ));
                  if (apply) {
                    List<String> topicIDs = [];
                    bool allFalse = true;
                    for (int i = 0; i < topics.length; i++) {
                      if (topicsChecked[i]) {
                        allFalse = false;
                        topicIDs.add(topics[i].topicID);
                      }
                    }
                    if (allFalse)
                      for (int i = 0; i < topics.length; i++)
                        topicIDs.add(topics[i].topicID);
                    setState(() {
                      isLoaded = false;
                    });
                    previews = await API.getTestByTopicIDs(topicIDs, context);
                    setState(() {
                      isLoaded = true;
                    });
                  }
                },
                icon: Icon(
                  Icons.filter_alt_outlined,
                )),
          )
        ],
      ),
    );
  }

  _buildListTest() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => TestPreviewCard(
            preview: previews[index],
            isFirst: index == 0,
            isInTestChoosingScreen: true,
          ),
          itemCount: previews.length,
        ),
      ),
    );
  }
}

class TopicCheckboxDialog extends StatefulWidget {
  final List<bool> topicsChecked;
  final List<Topic> topics;
  TopicCheckboxDialog({@required this.topicsChecked, @required this.topics});

  @override
  _TopicCheckboxDialogState createState() => _TopicCheckboxDialogState();
}

class _TopicCheckboxDialogState extends State<TopicCheckboxDialog> {
  List<bool> topicsChecked;

  @override
  void initState() {
    super.initState();
    topicsChecked = widget.topicsChecked;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Filter by topics",
          style: Theme.of(context).textTheme.headline5,
        ),
        content: _topicCheckboxList(),
        contentPadding: EdgeInsets.all(10.0),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(secondaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
              child: Text(
                "Apply",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Colors.black.withOpacity(0.07))),
              child: Text(
                "Cancel",
                style: Theme.of(context).accentTextTheme.headline6,
              )),
        ]);
  }

  _topicCheckboxList() {
    return SizedBox(
      width: 300,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: topicsChecked[index],
              onChanged: (value) {
                setState(() {
                  topicsChecked[index] = value;
                });
              },
            ),
            SizedBox(width: 5),
            Text(
              widget.topics[index].name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        itemCount: topicsChecked.length,
      ),
    );
  }
}
