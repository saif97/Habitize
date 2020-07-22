import 'package:flutter/material.dart';

import '../../presentation/habit_info/sub_monthly_calendar.dart';
import '../../ui/shared/constants.dart';
import '../../domain/habit/Habit.dart';
import '../functions.dart';

//TODO: by using ValueListenableBuilder I don't need to use basemodels anymore.
class ModelHabitInfo {
  final Habit _habit;

  List<List<Widget>> getMatrixDateCircles(String month) {
    final List<List<Widget>> matrixDateCircles = [];
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, months.indexOf(month) + 1);

    final int weekday = firstDayOfMonth.weekday;

    final DateTime firstMonday = firstDayOfMonth.subtract(Duration(days: weekday - 1));

    int dayCounter = 0;
    for (var row = 0; row < 6; ++row) {
      final List<Widget> widgetCol = <Widget>[];
      for (var col = 0; col < 7; ++col) {
        final date = firstMonday.add(Duration(days: dayCounter));
        widgetCol.add(DateCircle(date));
        dayCounter++;
      }
      matrixDateCircles.add(widgetCol);
    }
    return matrixDateCircles;
  }

  void checkHabitInCalender(DateTime date, {bool undo, bool checkAll}) {
    // make sure the checked date isn't not after today to prevent checks in future
    if (date.isBefore(getTodayDate().add(const Duration(days: 1)))) {
      if (undo)
        habit.utils.resetIteration(date);
      else
        habit.utils.checkHabit(date, checkAll: checkAll);
    }
  }

//=============> GETTERS & SETTERS <==============\\

  ModelHabitInfo(this._habit);

  Habit get habit => _habit;
}
