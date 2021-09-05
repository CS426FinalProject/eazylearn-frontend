import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/colors.dart';
import 'package:flutter/material.dart';

class QuestionWheel extends StatefulWidget {
  final ValueChanged<double> onScroll;
  final ValueChanged<PageController> onControllerCreated;
  final int questionNumber;
  final List<int> userChoices;
  final ValueChanged<int> onQuestionChosenByPicker;
  QuestionWheel(
      {@required this.onScroll,
      @required this.onControllerCreated,
      @required this.questionNumber,
      @required this.userChoices,
      @required this.onQuestionChosenByPicker});
  @override
  _QuestionWheelState createState() => _QuestionWheelState();
}

class _QuestionWheelState extends State<QuestionWheel> {
  PageController _controller;
  int selected = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 1 / 3,
    )..addListener(() {
        widget.onScroll(_controller.page);
      });
    widget.onControllerCreated(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(color: primaryColor),
      child: PageView.builder(
          onPageChanged: (index) {
            setState(() {
              selected = index;
            });
          },
          itemCount: widget.questionNumber,
          controller: _controller,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  if (selected != index)
                    setState(() {
                      _controller.animateToPage(index,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.ease);
                    });
                  else {
                    int chosen = await showDialog(
                            context: context,
                            builder: (context) => _buildQuestionPicker()) ??
                        selected;
                    widget.onQuestionChosenByPicker(chosen);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(
                          positive(1 - abs(index - selected) * 2 / 10))),
                  child: Center(
                      child: Text(
                    "${index + 1}",
                    style: Theme.of(context).accentTextTheme.headline5.copyWith(
                          fontSize: 20,
                        ),
                  )),
                ),
              )),
    );
  }

  int abs(int a) {
    return a > 0 ? a : -a;
  }

  double positive(double a) {
    return a <= 0 ? 0 : a;
  }

  Widget _buildQuestionPicker() {
    return Dialog(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.background,
        ),
        height: 350,
        width: 325,
        child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            physics: BouncingScrollPhysics(),
            itemCount: widget.questionNumber,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("before setting state");
                  Navigator.pop(context, index);
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kEzLearnShadowButton,
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        )
                      ],
                      color: selected == index
                          ? Theme.of(context).colorScheme.secondary
                          : (widget.userChoices[index] != -1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.surface),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: Theme.of(context)
                            .accentTextTheme
                            .headline5
                            .copyWith(
                              color: selected == index
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : (widget.userChoices[index] != -1
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      // child: SizedBox(
      //   width: 325,
      //   child: DraggableScrollableSheet(
      //     expand: false,
      //     builder: (context, scrollController) {
      //       return Container(
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(20),
      //           color: Theme.of(context).colorScheme.background,
      //         ),
      //         height: 350,
      //         width: 325,
      //         child: GridView.builder(
      //             padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      //             controller: scrollController,
      //             physics: BouncingScrollPhysics(),
      //             itemCount: widget.questionNumber,
      //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 5,
      //             ),
      //             itemBuilder: (context, index) {
      //               return GestureDetector(
      //                 onTap: () {
      //                   print("before setting state");
      //                   Navigator.pop(context, index);
      //                 },
      //                 child: Center(
      //                   child: Container(
      //                     margin: EdgeInsets.all(5),
      //                     height: 48,
      //                     width: 48,
      //                     decoration: BoxDecoration(
      //                       shape: BoxShape.circle,
      //                       boxShadow: [
      //                         BoxShadow(
      //                           color: kEzLearnShadowButton,
      //                           offset: Offset(0, 10),
      //                           blurRadius: 20,
      //                         )
      //                       ],
      //                       color: selected == index
      //                           ? Theme.of(context).colorScheme.secondary
      //                           : (widget.userChoices[index] != -1
      //                               ? Theme.of(context).colorScheme.primary
      //                               : Theme.of(context).colorScheme.surface),
      //                     ),
      //                     child: Center(
      //                       child: Text(
      //                         "${index + 1}",
      //                         style: Theme.of(context)
      //                             .accentTextTheme
      //                             .headline5
      //                             .copyWith(
      //                               color: selected == index
      //                                   ? Theme.of(context)
      //                                       .colorScheme
      //                                       .onSecondary
      //                                   : (widget.userChoices[index] != -1
      //                                       ? Theme.of(context)
      //                                           .colorScheme
      //                                           .onPrimary
      //                                       : Theme.of(context)
      //                                           .colorScheme
      //                                           .onSurface),
      //                             ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             }),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
