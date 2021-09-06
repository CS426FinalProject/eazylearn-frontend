import 'package:final_cs426/api/api.dart';
import 'package:final_cs426/constants/color.dart';
import 'package:final_cs426/constants/colors.dart';
import 'package:final_cs426/models/user.dart';
import 'package:final_cs426/screens/history_screen.dart';
import 'package:final_cs426/screens/profile_screens/profile_editting_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  bool isLoaded = false;
  Future getProfile() async {
    user = await API.getProfile(Session.userID, context);

    if (user != null)
      setState(() {
        isLoaded = true;
        print(user.dob.toIso8601String());
      });
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    print(Session.userID);
    if (!isLoaded)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(children: [
              _buildAppBar(context),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(children: [
                  Row(
                    children: [
                      _buildUpperBox(
                        isTotal: true,
                        heading: "Finished test",
                        num: user.totalTest,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _buildUpperBox(
                            isTotal: false,
                            heading: "Average score",
                            num: user.avgScore,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ]),
              ),
              _buildPersonalInfoCard(context)
            ]),
            _buildNameCard(context)
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: _buildRoundedBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Personal info",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () async {
                          await _edit(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date of birth",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: kEzLearnGrey),
                          ),
                          Text(
                            DateFormat("dd/MM/yyyy").format(user.dob),
                            style: Theme.of(context).accentTextTheme.headline6,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dial num",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: kEzLearnGrey),
                          ),
                          Text(
                            user.phone,
                            style: Theme.of(context).accentTextTheme.headline6,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Email address:",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: kEzLearnGrey),
                ),
                Text(
                  user.email,
                  style: Theme.of(context).accentTextTheme.headline6,
                )
              ],
            ),
          )),
    );
  }

  Widget _buildRoundedBox({@required Color color, @required Widget child}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }

  Widget _buildUpperBox(
      {@required String heading,
      @required String num,
      @required Color color,
      @required bool isTotal}) {
    var screenWidth = MediaQuery.of(context).size.width;
    var boxSize = (screenWidth - 120) / 2;
    return GestureDetector(
        onTap: () {
          print(Session.userID);
          if (isTotal)
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryScreen(
                          userID: Session.userID,
                        )));
        },
        child: _buildRoundedBox(
          color: color,
          child: SizedBox(
            width: boxSize,
            height: boxSize,
            child: Column(
              children: [
                Text(
                  heading,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: color == Theme.of(context).colorScheme.secondary
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.onPrimary,
                        fontSize: 22,
                      ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    num,
                    style: Theme.of(context).accentTextTheme.headline6.copyWith(
                          fontSize: 48,
                          color:
                              color == Theme.of(context).colorScheme.secondary
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Widget _buildAppBar(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(color: primaryColor),
        child: Center(
          child: CircleAvatar(
            radius: 120,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 100,
              backgroundImage: Image.asset(
                "lib/images/default_avatar.png",
                fit: BoxFit.fill,
              ).image,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 40, left: 5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 40,
            color: Colors.white,
          ))
    ]);
  }

  Widget _buildNameCard(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 340, left: 20, right: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.firstname + " " + user.lastname,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 5),
                  Text(
                    user.username,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: kEzLearnGrey),
                  ),
                ],
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async {
                    print("asdf");
                    await _edit(context);
                  },
                  icon: Icon(Icons.edit),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future _edit(BuildContext context) async {
    user = await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) => ProfileEdittingScreen(
              user: user,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
    setState(() {});
  }
}
