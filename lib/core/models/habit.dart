import 'package:flutter/material.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:intl/intl.dart';


class Habit {
  ///
  //    mode:
  //       0: major habits where you can only have one such habit. Checking it makes your day successful.
  //       else, the rest of the habits won't be counted.
  //
  //       1: after a streak of 66 days of doing the habit, Major habits will be moved here.
  //       3: bonus habits such as brushing teeth, shower once.
  ///

  static final int HABIT_MODE_MAJOR = 0;
  static final int HABIT_MODE_BONUS = 1;

  @required
  final int id;
  @required
  String name;
  final int streak;
  Map<int, int> dates;

  int mode;

  // number of iterations.
  int goal;

  Habit({this.id, this.dates, this.name, this.streak, this.goal, this.mode}) {
    dates ??= Map<int, int>();
  }

  factory Habit.fromMap(Map map, int id) {
    Map<int, int> listDate = Map();

    (map[HABIT_DATES] as Map)
        ?.forEach(((k, v) => listDate.addAll({int.parse(k): v})));

    var habit = Habit(
      id: id,
      name: map[HABIT_NAME],
      streak: map[HABIT_STREAK] ?? 0,
      dates: listDate,
      goal: map[HABIT_GOAL],
      mode: map[HABIT_MODE],
    );
    return habit;
  }

  Map<String, dynamic> toMap() {
    var r = {
      HABIT_NAME: this.name,
      HABIT_STREAK: this.streak,
      HABIT_DATES: this.dates,
      HABIT_GOAL: this.goal,
      HABIT_MODE: this.mode,
    };
    return r;
  }

  printData({bool detailedDatesInfo = false, bool onlyThisMonth = true}) {
    String map = '';
    // sort the keys decending order to have latest days checked first printed.
    List<int> listSortedKeys = dates.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    DateFormat formatter = DateFormat('yyyy-MM-dd');
    for (int dateInMill in listSortedKeys) {
      int iteration = dates[dateInMill];

      if (detailedDatesInfo || ((!detailedDatesInfo) && iteration == 0)) {
        var date = DateTime.fromMillisecondsSinceEpoch(dateInMill);

        // only print dates from this month.
        if (onlyThisMonth &&
            date.isBefore(DateTime(DateTime.now().year, DateTime.now().month)))
          break;

        var formatedDateString = formatter.format(date);

        map += " \t $formatedDateString : $iteration , \n";
      }
    }

    dates.forEach((k, v) {});
    String str = "---------- START ----------  \n"
        "ID: $id \n"
        "Name: $name\n"
        "Streak: $streak\n"
        "Checked On:\n$map\n"
        "---------- END ----------  \n";
    print(str);
  }

  printThisMonthDates() {
    // sort the keys decending order to have latest days checked first printed.
    List<int> listSortedKeys = dates.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    listSortedKeys.forEach((dateInMill) {
      int iteration = dates[dateInMill];
      if (iteration > 0) {
        var formatedDateString =
            formatter.format(DateTime.fromMillisecondsSinceEpoch(dateInMill));

//        map += " $formatedDateString : $iteration ,";
      }
    });

    String str = "---------- START ----------  \n"
        "Name: $name\n"
        "---------- END ----------  \n";
  }
}
