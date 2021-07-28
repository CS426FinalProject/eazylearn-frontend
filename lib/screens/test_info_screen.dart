import 'dart:math';

import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/utility/test_info_appbar.dart';
import 'package:flutter/material.dart';

class TestInfoScreen extends StatefulWidget {
  final Topic topic;
  TestInfoScreen({@required this.topic});
  @override
  _TestInfoScreenState createState() => _TestInfoScreenState();
}

class _TestInfoScreenState extends State<TestInfoScreen> {
  List<bool> corrects = List.generate(40, (index) => Random().nextBool());
  bool init = true;
  bool byebye = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      setState(() => init = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("init");
    return WillPopScope(
      onWillPop: () {
        byebye = true;
        setState(() {
          init = true;
        });
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TestInfoAppbar(
              topic: widget.topic,
            ),
            AnimatedSwitcher(
                transitionBuilder: (child, animation) {
                  if (byebye) {
                    Animation<Offset> offset =
                        Tween<Offset>(begin: Offset.zero, end: Offset.infinite)
                            .animate(animation);
                    return SlideTransition(position: offset);
                  }
                  return FadeTransition(child: child, opacity: animation);
                },
                duration: Duration(milliseconds: 1400),
                child: init
                    ? SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              "This test revises the basic of double intergrals, "
                              "partial derivatives, blah blah blah blah blah blah"
                              " blah blah blah blah blah blah blah blah blah blah"
                              " blah blah blah blah blah blah blah blah blah blah"
                              " blah blah blah blah blah blah blah blah blah blah"
                              " blah blah blah blah blah blah blah blah blah blah"
                              " blah blah blah bla",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
