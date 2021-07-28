import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/utility/gradient_icon.dart';
import 'package:final_cs426/utility/topic_card.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math; // import this

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  FocusNode inputFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    if (value == 0) {
      inputFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Topic> topics = [];
    topics.add(Topic(
        name: "Calculus III",
        description: "This test revises...",
        time: 45,
        difficulty: 3,
        color: cal));
    topics.add(Topic(
        name: "Statistics I",
        description: "This test revises...",
        time: 60,
        difficulty: 2,
        color: stat));
    topics.add(Topic(
        name: "General Physics II",
        description: "This test revises...",
        time: 45,
        difficulty: 2,
        color: phy));
    topics.add(Topic(
        name: "Database",
        description: "This test revises...",
        time: 15,
        difficulty: 3,
        color: db));

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Row(
                children: [
                  IconButton(
                      iconSize: 50,
                      onPressed: () {},
                      icon: GradientIcon(
                        colors: [top_icon_1, top_icon_2],
                        icon: Icons.account_circle,
                      )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: IconButton(
                        iconSize: 50,
                        onPressed: () {},
                        icon: GradientIcon(
                          colors: [top_icon_1, top_icon_2],
                          icon: Icons.sort,
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            )),
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: 70,
              collapsedHeight: 70,
              expandedHeight: 70,
              floating: true,
              snap: true,
              title: Column(
                children: [
                  TextFormField(
                    focusNode: inputFocusNode,
                    style: TextStyle(fontSize: 18),
                    decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        contentPadding: EdgeInsets.only(
                            left: 18, bottom: 20, top: 20, right: 15),
                        hintText: "Search for tests, topics,..."),
                  ),
                ],
              ),
            )
          ],
          physics: NeverScrollableScrollPhysics(),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "Popular now",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Container(
                  height: 350,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          TopicCard(topic: topics[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 20,
                          ),
                      itemCount: topics.length)),
            ]),
          ),
        ),
      ),
    );
  }
}
