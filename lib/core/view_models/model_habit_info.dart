import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/view_models/base_model.dart';
import 'package:habitize3/ui/screens/habit_info/sub_monthly_calendar.dart';
import 'package:habitize3/ui/shared/constants.dart';

//TODO: by using ValueListenableBuilder I don't need to use basemodels anymore.
class ModelHabitInfo extends BaseModel {
  Habit _habit;

  List<List<Widget>> getMatrixDateCircles(String month) {
    final List<List<Widget>> matrixDateCircles = [];
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth =
        DateTime(now.year, months.indexOf(month) + 1);

    final int weekday = firstDayOfMonth.weekday;

    final DateTime firstMonday =
        firstDayOfMonth.subtract(Duration(days: weekday - 1));

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
      habit.checkHabitDone(date, undo: undo, checkAll: checkAll);
    }
  }

//=============> GETTERS & SETTERS <==============\\

  ModelHabitInfo(this._habit);

  Habit get habit => _habit;
}
