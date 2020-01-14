import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/ui/screens/screen_habit_list/bottom_time_line.dart';

import '../utils/functions.dart';
import 'base_model.dart';

class ModelHabitList extends BaseModel {
  DB_API db_api = locator();

  Habit _majorHabit;

  DateTime _selectedDate = getTodayDate();
  Habit _selectedHabit;

  List<Habit> _listHabits;
  List<Widget> bottomBarElements;

  ModelHabitList();

  Future initModel() async {
    setDefualtState(Model2State.busy);
    _majorHabit = await db_api.getMajorHabit();
    _listHabits = await db_api.getAllHabits();
    buildTimelineCircles();
  }

  String getTitle() {
    String str;
    int dayDiffer = getTodayDate().difference(selectedDate).inDays;

    switch (dayDiffer) {
      case 0:
        str = 'Today';
        break;
      case 1:
        str = 'Yesterday';
        break;
      default:
        str = dayDiffer.toString() + ' Days ago';
    }
    return str;
  }

  buildTimelineCircles() {
    bottomBarElements = List();
    // every iteration of indexDay, it moves backward one step (one day before)
    for (int indexDay = 0; indexDay < 7; indexDay++) {
      DateTime day = getTodayDate().subtract(Duration(days: indexDay));

      bool isAllchecked = false;
      if (_majorHabit != null) {
        DateTime date = getTodayDate().subtract(Duration(days: indexDay));
        isAllchecked = db_api.isHabitChecked(habit: _majorHabit, date: date);
      }

      bottomBarElements.add(TimeLineCircle(day, isAllchecked));
    }
    bottomBarElements = List.from(bottomBarElements.reversed);
  }

  String getHabitStreak() {
    // get how many days the habit is checked in a row by, getting the last day
    // the habit was checked & compare it to today or yesterday.
    int streak = 1;

    Map<int, int> dates = selectedHabit.dates;
    List<int> ordredDateKeys = dates.keys.toList()..sort();

    // is the habit checked before.
    if (ordredDateKeys.length > 0) {
      int todayInMilSecs = getTodayDateInt();

      int yesterdayInMilSecs = getTodayDateInt(addDuration: Duration(days: -1));

      bool bool1 =
          dates.containsKey(todayInMilSecs) && dates[todayInMilSecs] <= 0;

      bool bool2 = dates.containsKey(yesterdayInMilSecs) &&
          dates[yesterdayInMilSecs] <= 0;

      if (bool1 || bool2) {
        selectedHabit.printData(detailedDatesInfo: true);
        // iterate over all the dates in the map and check if they're in row.
        for (var i = ordredDateKeys.length - 2; i > 0; --i) {
          DateTime date1 =
              DateTime.fromMillisecondsSinceEpoch(ordredDateKeys.elementAt(i));

          if (!db_api.isHabitChecked(habit: selectedHabit, date: date1)) break;

          var date2 = DateTime.fromMillisecondsSinceEpoch(
              ordredDateKeys.elementAt(i - 1));

          if (!db_api.isHabitChecked(habit: selectedHabit, date: date2)) break;

          if (date1.difference(date2) == Duration(days: 1))
            streak++;
          else
            break;
        }
      }

      if (streak == 1)
        return 'Check today to have your first streak';
      else {
        if (streak < 21)
          return streak.toString() + ' => 21';
        else if (streak < 43)
          return streak.toString() + ' => 43';
        else if (streak < 66) return streak.toString() + '66';
        return streak.toString();
      }
    }
  }

  Future loadHabits() async {
    _listHabits = await db_api.getAllHabits();
    notifyListeners();
    print("=========list updated=========");
  }

//=============> GETTER & SETTERS <==============\\

  Habit get selectedHabit => _selectedHabit;

  set selectedHabit(Habit value) {
    _selectedHabit = value;
  }

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  List<Habit> get listHabits => _listHabits;
}
