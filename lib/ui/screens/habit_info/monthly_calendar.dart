import 'package:flutter/material.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_info.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:provider/provider.dart';

class MonthlyCalender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> untilCurrentMonth = months.sublist(0, getTodayDate().month);

    PageController pageController =
        PageController(initialPage: untilCurrentMonth.length);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Card(
        child: PageView(
          controller: pageController,
          children: untilCurrentMonth
              .map((String month) => OneMonthCalender(month))
              .toList(),
        ),
      ),
    );
  }
}

class OneMonthCalender extends StatelessWidget {
  final String month;

  OneMonthCalender(this.month);

  @override
  Widget build(BuildContext context) {
    ModelHabitInfo model = Provider.of(context);
    List<List<Widget>> matrixDateCircles = model.getMatrixDateCircles(month);

    return Column(
      children: <Widget>[
        Text(month),
        Row(
          children: [
            for (var str in weekDaysNames) StandardBox(child: Text(str))
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Expanded(
          // didn't use gid bcz I had issues aligning it w/ the weekday names
          child: Column(
            children: <Widget>[
              for (var i = 0; i < matrixDateCircles.length; ++i)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var j = 0; j < matrixDateCircles[i].length; ++j)
                      matrixDateCircles[i][j]
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}

class DateCircle extends StatefulWidget {
  DateTime date;

  DateCircle(this.date);

  @override
  _DateCircleState createState() => _DateCircleState();
}

class _DateCircleState extends State<DateCircle> {
  bool isChecked;
  bool isLeftChecked;
  bool isRightChecked;
  ModelHabitInfo model;
  DB_API _db_api = locator();

  @override
  Widget build(BuildContext context) {
    model ??= Provider.of(context);

      isChecked = _db_api.isHabitChecked(habit: model.habit, date: widget.date);

      isLeftChecked = _db_api.isHabitChecked(
          habit: model.habit, date: widget.date.subtract(Duration(days: 1)));

      isRightChecked = _db_api.isHabitChecked(
          habit: model.habit, date: widget.date.add(Duration(days: 1)));

    return Stack(
      children: <Widget>[
        isChecked && isRightChecked
            ? Positioned(
                right: 0,
                bottom: 20,
                child: Center(
                  child: Container(
                    width: 25,
                    height: 10,
                    color: Colors.greenAccent,
                  ),
                ),
              )
            : Container(),
        isChecked && isLeftChecked
            ? Positioned(
                left: 0,
                bottom: 20,
                child: Center(
                  child: Container(
                    width: 25,
                    height: 10,
                    color: Colors.greenAccent,
                  ),
                ),
              )
            : Container(),
        StandardBox(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              checkHabitInCalender();
            },
            onLongPress: () {
              checkHabitInCalender(checkAll: !isChecked);
            },
            child: CircleAvatar(
              backgroundColor: isChecked ? Colors.greenAccent : Colors.black,
              foregroundColor:
                  widget.date == getTodayDate() ? Colors.redAccent : null,
              child: Text((widget.date.day).toString()),
            ),
          ),
        )
      ],
    );
  }

  void checkHabitInCalender({bool checkAll}) async {
    // make sure the checked date isn't not after today to prevent checks in future
//    if (widget.date.isBefore(getTodayDate().add(Duration(days: 1)))) {
//      await db.checkHabitDone(
//        selectedHabit.id,
//        widget.date,
//        undo: isChecked,
//        checkAll: checkAll,
//      );
//      setState(() {
//        isChecked = !isChecked;
//        print("===================pot============================");
//        print(isChecked);
//        print("===============================================");
//      });
//    }
  }
}

class StandardBox extends StatelessWidget {
  Widget child;

  StandardBox({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 50,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Center(child: child),
    );
  }
}
