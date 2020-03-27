import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/serivces/db_api/db.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/screens/habit_info/screen_habit_info.dart';

class ModelHabitCard {
  ModelHabitList modelHabitList = locator<ModelHabitList>();
  bool _isHabitChecked;
  bool _isExtendedGoalChecked;
  String _habitStreak;
  Key _key;
  final Habit habit;
  final DateTime selectedDate;

  void initModel() {
    _isHabitChecked = habit.utils.isHabitChecked(selectedDate);

    _habitStreak = _getHabitStreak();

    _key = Key(
        "${habit.key}-${habit.dates[selectedDate.millisecondsSinceEpoch] ?? -2}");
  }

  Future openHabitInfo(BuildContext context) async {
    final bool r = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ScreenHabitInfo(habit)));
    if (r ?? false) {
      modelHabitList.initModel();
    }
  }

  String _getHabitStreak() {
    // get how many days the habit is checked in a row by, getting the last day
    // the habit was checked & compare it to today or yesterday.
    int streak = 1;
    final Map<int, int> dates = habit.dates.cast<int, int>();
    final List<int> ordredDateKeys = dates.keys.toList()..sort();

    // is the habit checked before.
    final int todayInMilSecs = getTodayDateInt();

    final int yesterdayInMilSecs =
        getTodayDateInt(addDuration: const Duration(days: -1));

    // check if today and yesterday are stored in the habit.
    if (dates.containsKey(todayInMilSecs) &&
        dates.containsKey(yesterdayInMilSecs)) {
      // check if today and yesterday for this habit is checked all or more.
      // all in this case is 0 more is in the minus.
      final bool bool1 = dates[todayInMilSecs] <= 0;
      final bool bool2 = dates[yesterdayInMilSecs] <= 0;

      if (bool1 || bool2) {
        // iterate over all the dates in the map and check if they're in row.
        for (var i = ordredDateKeys.length - 1; i > 0; --i) {
          final DateTime date1 =
              DateTime.fromMillisecondsSinceEpoch(ordredDateKeys.elementAt(i));

          if (!habit.utils.isHabitChecked(date1)) break;

          final date2 = DateTime.fromMillisecondsSinceEpoch(
              ordredDateKeys.elementAt(i - 1));

          if (!habit.utils.isHabitChecked(date2)) break;

          if (date1.difference(date2) == const Duration(days: 1))
            streak++;
          else
            break;
        }
      }
    }

    if (streak == 1)
      return 'Check today to have your first streak';
    else {
      if (streak < 21)
        return '${streak.toString()} => 21';
      else if (streak < 43)
        return '${streak.toString()} => 43';
      else if (streak < 66) return '${streak.toString()} => 66';
      return streak.toString();
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

  Future<bool> slidableOnWillDismiss(SlideActionType actionType) async {
    if (actionType == SlideActionType.primary) {
      // check if habit is checked for today.
      await slidableCheckHabit(checkAll: false);
      return true;
    }
    return false;
  }

  Future slidableCheckHabit({@required bool checkAll}) async {
    habit.utils.checkHabit(selectedDate, checkAll: checkAll);

    await modelHabitList.initModel();
  }

  Future deleteHabit() async {
    final DB db = locator<DB>();
    await db.delete(habit.key);
    await modelHabitList.initModel();
  }

  Text getIterationText() {
    int iteration =
        habit.dates[selectedDate.millisecondsSinceEpoch] ?? 0;

    if (isHabitChecked && habit.extendedGoal != null) {
      return Text("$iteration / ${habit.extendedGoal}");
    } else
      return habit.goal > 1 ? Text("$iteration / ${habit.goal}") : null;
  }

  //=============> GETTERS & SETTERS <==============\\

  ModelHabitCard(this.habit, this.selectedDate) {
    initModel();
  }

  bool get isHabitChecked => _isHabitChecked;

  String get habitStreak => _habitStreak;

  Key get key => _key;
}
