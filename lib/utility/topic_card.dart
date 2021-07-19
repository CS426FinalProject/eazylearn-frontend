import 'package:final_cs426/models/topic.dart';
import 'package:final_cs426/screens/test_info_screen.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;

  const TopicCard({@required this.topic});
  @override
  Widget build(BuildContext context) {
    List<Image> list = [];
    for (int i = 0; i < topic.difficulty; i++) {
      list.add(Image.asset(
        "lib/images/flash.png",
        scale: 30,
      ));
    }
    return Hero(
      tag: "main_to_info_${topic.name}",
      child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: topic.colors),
                  borderRadius: BorderRadius.circular(30)),
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(seconds: 1),
                                pageBuilder: (_, __, ___) => TestInfoScreen()));
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
                          child: Row(children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                topic.image,
                                scale: 10,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(topic.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      topic.time.toString() + " min",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Row(
                                      children: list,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ])))))),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey,
    //           blurRadius: 5.0,
    //           offset: Offset(3.0, 3.0),
    //         )
    //       ],
    //       gradient: LinearGradient(colors: topic.colors),
    //       borderRadius: BorderRadius.circular(30)),
    //   child: Material(
    //     color: Colors.transparent,
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(30),
    //       onTap: () {},
    //       child: Padding(
    //         padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
    //         child: Row(
    //           children: [
    //             CircleAvatar(
    //               radius: 40,
    //               backgroundColor: Colors.white,
    //               child: Image.asset(
    //                 topic.image,
    //                 scale: 10,
    //               ),
    //             ),
    //             SizedBox(
    //               width: 30,
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(topic.name,
    //                     style: TextStyle(
    //                         fontSize: 20,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white)),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Row(
    //                   children: [
    //                     Text(
    //                       topic.time.toString() + " min",
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                     SizedBox(
    //                       width: 40,
    //                     ),
    //                     Row(
    //                       children: list,
    //                     )
    //                   ],
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
