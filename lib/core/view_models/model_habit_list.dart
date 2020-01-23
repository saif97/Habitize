import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/serivces/db_api/hive_db.dart';
import 'package:habitize3/ui/screens/habit_list/bottom_time_line.dart';

import '../utils/functions.dart';
import 'base_model.dart';

class ModelHabitList extends BaseModel {
  Habit _majorHabit;

  DateTime _selectedDate = getTodayDate();

  List<Widget> bottomBarElements;

  final keyAnimatedList = GlobalKey<AnimatedListState>();

  void initModel() {
    _majorHabit = Hive_DB_API.getMajorHabit();

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
        isAllchecked = _majorHabit.isHabitChecked(date);
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

  List<Habit> filterHabits(List listHabits,
          {List<HabitMode> habitMode, @required bool showChecked}) =>
      (listHabits.cast<Habit>())?.where((habit) {
        final bool isHabitChecked = habit.isHabitChecked(_selectedDate);

        return habitMode.contains(habit.mode) && isHabitChecked == showChecked;
      })?.toList() ??
      [];

  Habit get majorHabit => _majorHabit;
}
