import 'dart:math';

import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/utility/correctness.dart';
import 'package:final_cs426/utility/result_circle.dart';
import 'package:flutter/material.dart';

class TestInfoScreen extends StatefulWidget {
  @override
  _TestInfoScreenState createState() => _TestInfoScreenState();
}

class _TestInfoScreenState extends State<TestInfoScreen> {
  List<bool> corrects = List.generate(40, (index) => Random().nextBool());
  bool init = true;
  Future sleep() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    setState(() {
      init = false;
    });
  }

  @override
  void initState() {
    sleep();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Image> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(Image.asset(
        "lib/images/flash.png",
        scale: 20,
      ));
    }
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 120, 20, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  "Number of exercise",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("30", style: TextStyle(fontSize: 20)),
                ))
              ],
            ),
            Divider(
              height: 40,
              thickness: 2,
            ),
            Row(
              children: [
                Text(
                  "Difficulty",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: list,
                  ),
                )
              ],
            ),
            Divider(
              height: 40,
              thickness: 2,
            ),
            Row(
              children: [
                Text(
                  "Time",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("30 min", style: TextStyle(fontSize: 20)),
                ))
              ],
            ),
            Divider(
              height: 40,
              thickness: 2,
            ),
            Text(
              "Description:\nThis test revises bla bla",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              flex: 3,
              child: Center(
                  child: Correctness(
                corrects: corrects,
              )),
            ),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(300, 40)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(secondaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Text(
                      "START",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ))
          ]),
        ),
        AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            alignment: init ? Alignment.center : Alignment.bottomCenter,
            duration: Duration(seconds: 1),
            width: MediaQuery.of(context).size.width,
            height: init ? MediaQuery.of(context).size.height : 90,
            decoration: BoxDecoration(color: primaryColor),
            child: AnimatedDefaultTextStyle(
              duration: Duration(seconds: 1),
              child: Text(
                "Calculus III",
              ),
              style: TextStyle(
                  fontSize: init ? 60 : 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            )),
      ],
    ));
  }
}
