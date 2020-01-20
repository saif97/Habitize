import 'package:flutter/material.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/view_models/model_habit_info.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:provider/provider.dart';

class MonthlyCalender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> untilCurrentMonth =
        months.sublist(0, getTodayDate().month);

    final PageController pageController =
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

  const OneMonthCalender(this.month);

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelHabitInfo>(
      builder: (_, model, __) {
        final List<List<Widget>> matrixDateCircles =
            model.getMatrixDateCircles(month);

        return Column(
          children: <Widget>[
            Text(month),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var str in weekDaysNames) StandardBox(child: Text(str))
              ],
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
      },
    );
  }
}

class DateCircle extends StatefulWidget {
  final DateTime date;

  const DateCircle(this.date);

  @override
  _DateCircleState createState() => _DateCircleState();
}

class _DateCircleState extends State<DateCircle> {
  bool isChecked;
  bool isLeftChecked;
  bool isRightChecked;
  ModelHabitInfo model;

  @override
  Widget build(BuildContext context) {
    model ??= Provider.of(context);

    isChecked = model.habit.isHabitChecked(widget.date);

    isLeftChecked = model.habit
        .isHabitChecked(widget.date.subtract(const Duration(days: 1)));

    isRightChecked =
        model.habit.isHabitChecked(widget.date.add(const Duration(days: 1)));

    return Stack(
      children: <Widget>[
        if (isChecked && isRightChecked)
          Positioned(
            right: 0,
            bottom: 20,
            child: Center(
              child: Container(
                width: 25,
                height: 10,
                color: Colors.greenAccent,
              ),
            ),
          ),
        if (isChecked && isLeftChecked)
          Positioned(
            left: 0,
            bottom: 20,
            child: Center(
              child: Container(
                width: 25,
                height: 10,
                color: Colors.greenAccent,
              ),
            ),
          ),
        StandardBox(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => model.checkHabitInCalender(widget.date, undo: false),
            onLongPress: () => model.checkHabitInCalender(
              widget.date,
              undo: isChecked,
              checkAll: !isChecked,
            ),
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
}

class StandardBox extends StatelessWidget {
  final Widget child;

  const StandardBox({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 50,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Center(child: child),
    );
  }
}
