import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/base_model.dart';

class ModelHabitCard extends BaseModel {
  DB_API _db_api = locator();
  bool _isHabitChecked;
  String _currentIteration;
  String _habitStreak;
  Key _key;
  final Habit habit;
  final DateTime selectedDate;

  ModelHabitCard(this.habit, this.selectedDate) {
    _isHabitChecked = _db_api.isHabitChecked(habit: habit, date: selectedDate);

    _currentIteration = (habit.dates[selectedDate.millisecondsSinceEpoch] ??=
            habit.goal)
        .toString();
    _habitStreak = _getHabitStreak();

    _key = Key(
        "${habit.id}-${habit.dates[selectedDate.millisecondsSinceEpoch] ?? -2}");
  }

  openHabitInfo(BuildContext context) {
//		Navigator.push(
//				context,
//				MaterialPageRoute(
//						builder: (context) =>
//								ScreenHabitInfo(model.selectedHabit)));
  }

  String _getHabitStreak() {
    // get how many days the habit is checked in a row by, getting the last day
    // the habit was checked & compare it to today or yesterday.
    int streak = 1;

    Map<int, int> dates = habit.dates;
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
        habit.printData(detailedDatesInfo: true);
        // iterate over all the dates in the map and check if they're in row.
        for (var i = ordredDateKeys.length - 2; i > 0; --i) {
          DateTime date1 =
              DateTime.fromMillisecondsSinceEpoch(ordredDateKeys.elementAt(i));

          if (!_db_api.isHabitChecked(habit: habit, date: date1)) break;

          var date2 = DateTime.fromMillisecondsSinceEpoch(
              ordredDateKeys.elementAt(i - 1));

          if (!_db_api.isHabitChecked(habit: habit, date: date2)) break;

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

  String getSwipeRightText() {
    String swipeRightText;
    if (habit.goal > 1)
      swipeRightText = 'Done Once';
    else if (_isHabitChecked)
      swipeRightText = "Undo";
    else
      swipeRightText = "Done";
    return swipeRightText;
  }

  bool slidableOnWillDismiss(SlideActionType actionType) {
    if (actionType == SlideActionType.primary) {
      // check if habit is checked for today.
      _db_api.checkHabitDone(
        habit.id,
        selectedDate,
        undo: isHabitChecked,
      );
      return true;
    }
    return false;
  }

  Future<bool> slidableCheckAllHabits() =>
      _db_api.checkHabitDone(habit.id, selectedDate, checkAll: !isHabitChecked);

//=============> GETTERS & SETTERS <==============\\
  String get currentIteration => _currentIteration;

  bool get isHabitChecked => _isHabitChecked;

  String get habitStreak => _habitStreak;

  Key get key => _key;
}
