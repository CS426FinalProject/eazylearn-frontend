import 'package:final_cs426/api/API.dart';
import 'package:final_cs426/constants/colors.dart';
import 'package:final_cs426/models/result.dart';
import 'package:final_cs426/utility/history_card.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final String userID;
  HistoryScreen({@required this.userID});
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isLoaded = false;
  List<bool> checked;
  List<Result> results = [];
  List<Result> displayed = [];
  Future getResult() async {
    print(widget.userID);
    results = await API.getResultsByUserID(widget.userID);
    if (results != null) {
      setState(() {
        displayed = results;
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checked = List.generate(3, (index) => false);
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "HISTORY",
            style: Theme.of(context).textTheme.headline4,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [_buildSearchAndFilterBar(), _buildListHistory()],
          ),
        ),
      ),
    );
  }

  Widget _buildListHistory() {
    print(displayed.length);
    return Expanded(
        child: displayed.length == 0
            ? Center(
                child: Text("You haven't taken any tests!",
                    style: Theme.of(context).textTheme.bodyText2),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: displayed.length,
                itemBuilder: (context, index) =>
                    HistoryCard(result: displayed[index])));
  }

  Widget _buildSearchAndFilterBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      spreadRadius: 10,
                      color: Color(0x6D8DAD).withOpacity(0.25),
                    )
                  ]),
              child: TextFormField(
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search",
                  focusColor: Theme.of(context).colorScheme.primary,
                  border: InputBorder.none,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      spreadRadius: 10,
                      color: Color(0x6D8DAD).withOpacity(0.25))
                ]),
            child: IconButton(
                iconSize: 40,
                onPressed: () async {
                  final result = await showDialog(
                      context: context,
                      builder: (context) => FilterDialog(checked: checked));
                  displayed =
                      List.generate(results.length, (index) => results[index]);
                  setState(() {});
                  if (result != null && result) {
                    List<String> subjects = ["Math", "English", "Physic"];
                    List<String> selected = [];
                    for (int i = 0; i < 3; i++)
                      if (checked[i]) selected.add(subjects[i]);
                    print(selected);
                    if (selected.isEmpty) return;
                    setState(() {
                      displayed.removeWhere((element) {
                        print(element.test.name);

                        print(selected.contains(element.test.subject));
                        return !selected.contains(element.test.subject);
                      });
                    });
                  }
                },
                icon: Icon(
                  Icons.filter_alt_outlined,
                )),
          )
        ],
      ),
    );
  }
}

class FilterDialog extends StatefulWidget {
  final List<bool> checked;
  final List<String> subjects = ["Math", "English", "Physic"];

  FilterDialog({@required this.checked});
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<bool> checked;
  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    print(checked);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "Filter by topics",
        style: Theme.of(context).textTheme.headline5,
      ),
      content: _topicCheckboxList(),
      contentPadding: EdgeInsets.all(10.0),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kEzLearnYellow400),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
            child: Text(
              "Apply",
              style: Theme.of(context).accentTextTheme.headline6,
            )),
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.black.withOpacity(0.07))),
            child: Text(
              "Cancel",
              style: Theme.of(context).accentTextTheme.headline6,
            )),
      ],
    );
  }

  _topicCheckboxList() {
    return SizedBox(
      width: 300,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: checked[index],
              onChanged: (value) {
                setState(() {
                  checked[index] = value;
                });
              },
            ),
            SizedBox(width: 5),
            Text(
              widget.subjects[index],
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        itemCount: checked.length,
      ),
    );
  }
}
