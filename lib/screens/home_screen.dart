import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/models/test.dart';
import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/screens/profile_screens/profile_screen.dart';
import 'package:final_cs426/screens/test_screen.dart';
import 'package:final_cs426/utility/subject_card.dart';
import 'package:final_cs426/utility/test_preview_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode inputFocusNode = FocusNode();
  List<Subject> subjects;
  List<Test> previews = [];
  bool isLoaded = false;

  Future getSubjects() async {
    subjects = await API.getAllSubject(context);
    if (subjects != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSubjects();
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded)
      return Scaffold(
        body: Center(child: CircularProgressIndicator(color: primaryColor)),
      );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => inputFocusNode.unfocus(),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 7, child: _buildAppbar()),
                Expanded(
                    flex: 29,
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
            Column(
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildTextFormField(),
                      ],
                    )),
                Expanded(
                  flex: 17,
                  child: SizedBox.shrink(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField() {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 35, right: 35),
      child: Container(
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
      ),
    );
  }

  Widget _buildAppbar() {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
      width: double.infinity,
      decoration: BoxDecoration(color: primaryColor),
      child: Column(
        children: [
          SizedBox(height: 45),
          Row(
            children: [
              Text(
                "EAZYLEARN",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
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
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                        isInTestChoosingScreen: false,
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
