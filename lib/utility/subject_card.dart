import 'package:final_cs426/constants/colors.dart';
import 'package:final_cs426/models/subject.dart';
import 'package:final_cs426/screens/test_choosing_screen.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final bool isFirst;
  SubjectCard({@required this.subject, @required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.only(left: isFirst ? 35 : 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: subject.color, borderRadius: BorderRadius.circular(20)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => TestChoosingScreen(
                            subject: subject,
                          ),
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
                child: SizedBox(
                  width: 270,
                  height: 270,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              subject.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        subject.name,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: kEzLearnWhite,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
