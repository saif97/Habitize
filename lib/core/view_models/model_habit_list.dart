import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/ui/screens/screen_habit_list/bottom_time_line.dart';

import '../utils/functions.dart';
import 'base_model.dart';

class ModelHabitList extends BaseModel {
  DB_API db_api = locator<DB_API>();

  Habit _majorHabit;

  DateTime _selectedDate = getTodayDate();

  List<Habit> _listHabits;
  List<Widget> bottomBarElements;

  ModelHabitList();

  Future initModel() async {
    _majorHabit =
        (await db_api.getAllHabits(habitMode: HabitMode.Majror))?.first;
    _listHabits = await db_api.getAllHabits() ?? [];

    buildTimelineCircles();
    notifyListeners();
  }

  String getTitle() {
    String str;
    final int dayDiffer = getTodayDate().difference(selectedDate).inDays;

    switch (dayDiffer) {
      case 0:
        str = 'Today';
        break;
      case 1:
        str = 'Yesterday';
        break;
      default:
        str = '${dayDiffer.toString()} Days ago';
    }
    return str;
  }

  void buildTimelineCircles() {
    bottomBarElements = [];
    // every iteration of indexDay, it moves backward one step (one day before)
    for (int indexDay = 0; indexDay < 7; indexDay++) {
      final DateTime day = getTodayDate().subtract(Duration(days: indexDay));

      bool isAllchecked = false;
      if (_majorHabit != null) {
        DateTime date = getTodayDate().subtract(Duration(days: indexDay));
        isAllchecked = db_api.isHabitChecked(habit: _majorHabit, date: date);
      }

      bottomBarElements.add(TimeLineCircle(
        day,
        isAllchecked: isAllchecked,
      ));
    }
    bottomBarElements = List.from(bottomBarElements.reversed);
  }

//=============> GETTER & SETTERS <==============\\

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  List<Habit> getListHabits(
          {List<HabitMode> habitMode, @required bool showChecked}) =>
      _listHabits?.where((habit) {
        final bool isHabitChecked =
            db_api.isHabitChecked(habit: habit, date: _selectedDate);

        return habitMode.contains(habit.mode) && isHabitChecked == showChecked;
      })?.toList() ??
      [];

  Habit get majorHabit => _majorHabit;
}
