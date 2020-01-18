import 'package:flutter/material.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:intl/intl.dart';

enum HabitMode { Majror, Bonus }

class Habit {
  @required
  final int id;
  @required
  String name;
  final int streak;
  Map<int, int> dates;

  HabitMode mode;

  // number of iterations.
  int goal;

  Habit({this.id, this.dates, this.name, this.streak, this.goal, this.mode}) {
    dates ??= <int, int>{};
  }

  factory Habit.fromMap(Map map, int id) {
    final Map<int, int> listDate = <int, int>{};

    (map[HABIT_DATES])
        ?.forEach((String k, v) => listDate.addAll({int.parse(k): v as int}));

    final Habit habit = Habit(
      id: id,
      name: map[HABIT_NAME] as String,
      streak: map[HABIT_STREAK] as int ?? 0,
      dates: listDate,
      goal: map[HABIT_GOAL] as int,
      mode: modeFromString(map[HABIT_MODE] as String),
    );
    return habit;
  }

  Map<String, dynamic> toMap() => {
        HABIT_NAME: name,
        HABIT_STREAK: streak,
        HABIT_DATES: dates,
        HABIT_GOAL: goal,
        HABIT_MODE: mode.toString(),
      };

  void printData({bool detailedDatesInfo = false, bool onlyThisMonth = true}) {
    String map = '';
    // sort the keys decending order to have latest days checked first printed.
    final List<int> listSortedKeys = dates.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    for (final int dateInMill in listSortedKeys) {
      final int iteration = dates[dateInMill];

      if (detailedDatesInfo || ((!detailedDatesInfo) && iteration == 0)) {
        final date = DateTime.fromMillisecondsSinceEpoch(dateInMill);

        // only print dates from this month.
        if (onlyThisMonth &&
            date.isBefore(DateTime(DateTime.now().year, DateTime.now().month)))
          break;

        final formatedDateString = formatter.format(date);

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
    print(str); // don't you dare deleting this line.
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
