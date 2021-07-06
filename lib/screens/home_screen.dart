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
        name: "Calculus III", time: 45, difficulty: 3, colors: [cal1, cal2]));
    topics.add(Topic(
        name: "Statistics I", time: 60, difficulty: 2, colors: [stat1, stat2]));
    topics.add(Topic(
        name: "General Physics II",
        time: 45,
        difficulty: 2,
        colors: [phy1, phy2]));
    topics.add(
        Topic(name: "Database", time: 15, difficulty: 3, colors: [db1, db2]));
    topics.add(Topic(
        name: "Calculus III", time: 45, difficulty: 3, colors: [cal1, cal2]));
    topics.add(Topic(
        name: "Statistics I", time: 60, difficulty: 2, colors: [stat1, stat2]));
    topics.add(Topic(
        name: "General Physics II",
        time: 45,
        difficulty: 2,
        colors: [phy1, phy2]));
    topics.add(
        Topic(name: "Database", time: 15, difficulty: 3, colors: [db1, db2]));
    topics.add(Topic(
        name: "Calculus III", time: 45, difficulty: 3, colors: [cal1, cal2]));
    topics.add(Topic(
        name: "Statistics I", time: 60, difficulty: 2, colors: [stat1, stat2]));
    topics.add(Topic(
        name: "General Physics II",
        time: 45,
        difficulty: 2,
        colors: [phy1, phy2]));
    topics.add(
        Topic(name: "Database", time: 15, difficulty: 3, colors: [db1, db2]));

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.fromLTRB(25, 50, 25, 10),
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
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      contentPadding: EdgeInsets.only(
                          left: 18, bottom: 20, top: 20, right: 15),
                      hintText: "Search for tests, topics,..."),
                ),
              ],
            ),
          )
        ],
        physics: NeverScrollableScrollPhysics(),
        body: Padding(
            padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    TopicCard(topic: topics[index]),
                separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                itemCount: topics.length)),
      ),
    );
  }
}

// // Flutter code sample for SliverAppBar

// //This sample shows a [SliverAppBar] and it's behavior when using the
// //[pinned], [snap] and [floating] parameters.

// import 'package:flutter/material.dart';

// // This is the main application widget.
// class HomeScreen extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

// /// This is the stateful widget that the main application instantiates.
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// /// This is the private State class that goes with MyStatefulWidget.
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   bool _pinned = true;
//   bool _snap = false;
//   bool _floating = false;

// // [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// // turn can be placed in a [Scaffold.body].
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             pinned: _pinned,
//             snap: _snap,
//             floating: _floating,
//             expandedHeight: 160.0,
//             flexibleSpace: const FlexibleSpaceBar(
//               title: Text('SliverAppBar'),
//               background: FlutterLogo(),
//             ),
//           ),
//           const SliverToBoxAdapter(
//             child: SizedBox(
//               height: 20,
//               child: Center(
//                 child: Text('Scroll to see the SliverAppBar in effect.'),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Container(
//                   color: index.isOdd ? Colors.white : Colors.black12,
//                   height: 100.0,
//                   child: Center(
//                     child: Text('$index', textScaleFactor: 5),
//                   ),
//                 );
//               },
//               childCount: 20,
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: OverflowBar(
//             overflowAlignment: OverflowBarAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const Text('pinned'),
//                   Switch(
//                     onChanged: (bool val) {
//                       setState(() {
//                         _pinned = val;
//                       });
//                     },
//                     value: _pinned,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const Text('snap'),
//                   Switch(
//                     onChanged: (bool val) {
//                       setState(() {
//                         _snap = val;
//                         // Snapping only applies when the app bar is floating.
//                         _floating = _floating || _snap;
//                       });
//                     },
//                     value: _snap,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const Text('floating'),
//                   Switch(
//                     onChanged: (bool val) {
//                       setState(() {
//                         _floating = val;
//                         _snap = _snap && _floating;
//                       });
//                     },
//                     value: _floating,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
