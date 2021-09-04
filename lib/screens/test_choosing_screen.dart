import 'dart:ui';

import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/models/test_preview.dart';
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
  List<TestPreview> previews = [];
  List<Topic> topics;
  List<bool> topicsChecked;

  @override
  void initState() {
    super.initState();
    subject = widget.subject;
    topics = subject.topics;
    topicsChecked = List.generate(topics.length, (index) => false);

    previews.add(TestPreview(
      name: "Mid-term test",
      time: 30,
      subject: subject,
      topics: topics,
      difficulty: 3,
      description: "description",
    ));
    previews.add(TestPreview(
      name: "Final-term test",
      time: 30,
      subject: subject,
      topics: topics,
      difficulty: 3,
      description: "description",
    ));
    previews.add(TestPreview(
      name: "15-minute test",
      time: 30,
      subject: subject,
      topics: topics,
      difficulty: 3,
      description: "description",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 75,
        title: Text(
          subject.name.toUpperCase(),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                        color: Color(0x6D8DAD).withOpacity(0.25))
                  ]),
              child: TextFormField(
                style: TextStyle(fontSize: 18),
                focusNode: inputFocusNode,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: "Search",
                    focusColor: primaryColor,
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(20))),
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
                  await showDialog(
                      context: context,
                      builder: (context) => TopicCheckboxDialog(
                            topicsChecked: topicsChecked,
                            topics: topics,
                          ));
                  print(topicsChecked);
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: _topicCheckboxList(),
        actions: <Widget>[
          ElevatedButton(
              onPressed: Navigator.of(context).pop,
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
              onPressed: Navigator.of(context).pop,
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Colors.black.withOpacity(0.07))),
              child: Text(
                "Cancel",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
        ]);
  }

  _topicCheckboxList() {
    return SizedBox(
      width: 300,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Row(children: [
          (Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            value: topicsChecked[index],
            onChanged: (value) {
              setState(() {
                topicsChecked[index] = value;
              });
            },
          )),
          SizedBox(width: 5),
          Text(widget.topics[index].name)
        ]),
        itemCount: topicsChecked.length,
      ),
    );
  }
}
