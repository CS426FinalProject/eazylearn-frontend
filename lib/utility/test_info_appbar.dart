import 'dart:io';

import 'package:final_cs426/models/topic.dart';
import 'package:flutter/material.dart';

class TestInfoAppbar extends StatefulWidget {
  final Topic topic;
  TestInfoAppbar({@required this.topic});

  @override
  _TestInfoAppbarState createState() => _TestInfoAppbarState();
}

class _TestInfoAppbarState extends State<TestInfoAppbar> {
  List<Image> list = [];
  int count;
  bool init = true;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.topic.difficulty; i++) {
      list.add(Image.asset(
        "lib/images/flash.png",
        scale: 25,
      ));
    }
    //wait();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "main_to_info_${widget.topic.name}",
      child: Material(
          type: MaterialType.transparency,
          child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: widget.topic.color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              padding: EdgeInsets.fromLTRB(30, 55, 30, 25),
              child: Column(children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        widget.topic.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(widget.topic.name,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Wrap(children: [
                          Icon(Icons.timer, color: Colors.white),
                          Text(
                            " " + widget.topic.time.toString() + " min",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ]),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: list,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]))),
    );
  }
}

/*
Container(
          height: 400,
          padding: EdgeInsets.fromLTRB(30, 55, 30, 25),
          decoration: BoxDecoration(color: widget.topic.color),
          child: Column(children: [
            CircleAvatar(
              radius: 90,
              backgroundColor: Colors.white,
              child: Image.asset(
                widget.topic.image,
                scale: 5,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(widget.topic.name,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.timer, color: Colors.white),
                          Text(
                            " " + widget.topic.time.toString() + " min",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ]),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: list,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
*/