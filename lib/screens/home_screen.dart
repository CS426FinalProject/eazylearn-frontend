import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/models/test_preview.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/screens/profile_screen.dart';
import 'package:final_cs426/utility/subject_card.dart';
import 'package:final_cs426/utility/test_preview_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  FocusNode inputFocusNode = FocusNode();
  List<Subject> subjects = [];
  List<TestPreview> previews = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    subjects.add(Subject(name: "Mathematics", color: mth));
    subjects.add(Subject(name: "Physics", color: phy));
    subjects.add(Subject(name: "Database", color: db));

    previews.add(TestPreview(
        name: "Mid-term test",
        time: 30,
        subject: subjects[0],
        topics: [
          Topic(topicID: "MTH1", name: "Derivatives"),
          Topic(topicID: "MTH2", name: "Integrals")
        ],
        difficulty: 3,
        description: "description",
        color: mth));

    previews.add(TestPreview(
        name: "Final-term test",
        time: 30,
        subject: subjects[1],
        topics: [
          Topic(topicID: "PHY1", name: "Electricmagnetism"),
          Topic(topicID: "PHY2", name: "Optics")
        ],
        difficulty: 3,
        description: "description",
        color: phy));

    previews.add(TestPreview(
        name: "15-minute test",
        time: 30,
        subject: subjects[2],
        topics: [
          Topic(topicID: "DB1", name: "Recovery"),
          Topic(topicID: "DB2", name: "Concurrency control")
        ],
        difficulty: 3,
        description: "description",
        color: db));
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
    return GestureDetector(
      onTap: () {
        inputFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 1, child: _buildAppbar()),
                Expanded(
                    flex: 4,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        _buildListView(
                            category: "Popular now", isPreview: true),
                        _buildListView(
                            category: "All subject", isPreview: false),
                        _buildListView(
                            category: "All subject", isPreview: false),
                        // _buildListView(),
                        // _buildListView()
                      ],
                    ))
              ],
            ),
            _buildTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField() {
    return Padding(
      padding: EdgeInsets.only(left: 35, right: 35, top: 138),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        elevation: 5,
        child: TextFormField(
          focusNode: inputFocusNode,
          style: TextStyle(fontSize: 18),
          decoration: new InputDecoration(
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(color: Colors.transparent)),
              contentPadding:
                  EdgeInsets.only(left: 18, bottom: 20, top: 20, right: 15),
              hintText: "Search for tests, topics,..."),
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
      width: double.infinity,
      decoration: BoxDecoration(color: primaryColor),
      child: Row(
        children: [
          Text(
            "EAZYLEARN",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => ProfileScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            final tween = Tween(begin: begin, end: end);
                            final curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );

                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          }));
                    },
                  )))
        ],
      ),
    );
  }

  Widget _buildListView({@required String category, @required bool isPreview}) {
    print(subjects.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 35),
          child: Text(
            category,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Container(
            height: isPreview ? 150 : 300,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => isPreview
                    ? TestPreviewCard(
                        preview: previews[index],
                        isFirst: index == 0,
                      )
                    : SubjectCard(
                        subject: subjects[index], isFirst: index == 0),
                itemCount: isPreview ? previews.length : subjects.length)),
      ],
    );
  }

// @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: NestedScrollView(
  //       floatHeaderSlivers: true,
  //       headerSliverBuilder: (context, innerBoxIsScrolled) => [
  //         SliverToBoxAdapter(
  //             child: Padding(
  //           padding: EdgeInsets.fromLTRB(25, 50, 25, 10),
  //           child: Row(
  //             children: [
  //               IconButton(
  //                   iconSize: 50,
  //                   onPressed: () {},
  //                   icon: GradientIcon(
  //                     colors: [top_icon_1, top_icon_2],
  //                     icon: Icons.account_circle,
  //                   )),
  //               Expanded(
  //                   child: Align(
  //                 alignment: Alignment.centerRight,
  //                 child: Transform(
  //                   alignment: Alignment.center,
  //                   transform: Matrix4.rotationY(math.pi),
  //                   child: IconButton(
  //                     iconSize: 50,
  //                     onPressed: () {},
  //                     icon: GradientIcon(
  //                       colors: [top_icon_1, top_icon_2],
  //                       icon: Icons.sort,
  //                     ),
  //                   ),
  //                 ),
  //               ))
  //             ],
  //           ),
  //         )),
  //         SliverAppBar(
  //           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //           toolbarHeight: 70,
  //           collapsedHeight: 70,
  //           expandedHeight: 70,
  //           floating: true,
  //           snap: true,
  //           title: Column(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(left: 25, right: 25),
  //                 child: TextFormField(
  //                   focusNode: inputFocusNode,
  //                   style: TextStyle(fontSize: 18),
  //                   decoration: new InputDecoration(
  //                       focusedBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(10)),
  //                           borderSide:
  //                               BorderSide(color: Colors.grey, width: 2)),
  //                       enabledBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.all(Radius.circular(10)),
  //                           borderSide:
  //                               BorderSide(color: Colors.grey, width: 2)),
  //                       contentPadding: EdgeInsets.only(
  //                           left: 18, bottom: 20, top: 20, right: 15),
  //                       hintText: "Search for tests, topics,..."),
  //                 ),
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //       physics: NeverScrollableScrollPhysics(),
  //       body: SingleChildScrollView(
  //         child:
  //             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //           _buildDemo(),
  //         ]),
  //       ),
  //     ),
  //   );
  // }
}
