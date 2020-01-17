import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/view_models/base_model.dart';
import 'package:habitize3/ui/screens/habit_info/monthly_calendar.dart';
import 'package:habitize3/ui/shared/constants.dart';

class ModelHabitInfo extends BaseModel {
  Habit _habit;

	List<List<Widget>> getMatrixDateCircles(String month) {
    List<List<Widget>> matrixDateCircles = [];
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, months.indexOf(month) + 1);

    int weekday = firstDayOfMonth.weekday;

    DateTime firstMonday =
        firstDayOfMonth.subtract(Duration(days: weekday - 1));

    int dayCounter = 0;
    for (var row = 0; row < 6; ++row) {
      List<Widget> widgetCol = List<Widget>();
      for (var col = 0; col < 7; ++col) {
        var date = firstMonday.add(Duration(days: dayCounter));
        widgetCol.add(DateCircle(date));
        dayCounter++;
      }
      matrixDateCircles.add(widgetCol);
    }
    return matrixDateCircles;
  }

//=============> GETTERS & SETTERS <==============\\

  ModelHabitInfo(this._habit);

	Habit get habit => _habit;

}
