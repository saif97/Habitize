import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../presentation/screen_create_habit/screen_habit_creator.dart';
import '../../presentation/screen_habit_info/screen_habit_info.dart';
import '../../infrastructure/habit/Habit.dart';
import '../../domain/habit/db.dart';
import '../functions.dart';
import '../../locator.dart';
import 'model_habit_list.dart';

class ModelHabitCard {
  ModelHabitList modelHabitList = locator<ModelHabitList>();
  bool _isHabitChecked;

  String _habitStreak;
  Key _key;
  final Habit habit;
  final DateTime selectedDate;

  void initModel() {
    _isHabitChecked = habit.utils.isHabitChecked(selectedDate);

    _habitStreak = _getHabitStreak2();

    _key = Key("${habit.key}-${habit.dates[selectedDate.millisecondsSinceEpoch] ?? -2}");
  }

  Future openHabitInfo(BuildContext context) async {
    final bool r = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ScreenHabitInfo(habit)));
    if (r ?? false) {
      modelHabitList.initModel();
    }
  }

  String _getHabitStreak() {
    // get how many days the habit is checked in a row by, getting the last day
    // the habit was checked & compare it to today or yesterday.
    int streak = 0;
    final Map<int, int> dates = habit.dates;
    final List<int> ordredDateKeys = dates.keys.toList()..sort();

    // is the habit checked before.
    final int todayInMilSecs = getTodayDateInt();

    final int yesterdayInMilSecs = getTodayDateInt(addDuration: const Duration(days: -1));

    // check if today and yesterday for this habit is checked all or more.
    // all in this case is 0 more is in the minus.
    final bool bool1 = habit.utils.isHabitChecked(getTodayDate());
    final bool bool2 =
        habit.utils.isHabitChecked(getTodayDate(addDuration: const Duration(days: -1)));

    if (bool1 || bool2) {
      // iterate over all the dates in the map and check if they're in row.
      for (var i = ordredDateKeys.length - 1; i > 0; --i) {
        final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(ordredDateKeys.elementAt(i));
        if (!habit.utils.isHabitChecked(date1)) break;

        final date2 = DateTime.fromMillisecondsSinceEpoch(ordredDateKeys.elementAt(i - 1));
        if (!habit.utils.isHabitChecked(date2)) break;

        if (date1.difference(date2) == const Duration(days: 1))
          streak++;
        else
          break;
      }
    }

    if (streak < 21)
      return '${streak.toString()} => 21';
    else if (streak < 43)
      return '${streak.toString()} => 43';
    else if (streak < 66) return '${streak.toString()} => 66';
    return streak.toString();
  }

  // Note: Not checked habits will not be present in the dates map.
  String _getHabitStreak2() {
    int streak = 0;

    // check today OR yestday if checked.

    final List<int> ordredDateKeys = habit.utils.getListCheckedDatesKeys();

    // loop throgh the the dates
    for (int i = 0; i < ordredDateKeys.length; ++i) {
      DateTime date = dateFromInt(ordredDateKeys[i]);
      print(printDate(date));
      if (habit.utils.isHabitChecked(date)) {
        streak++;
        // check if the next date is tomrrow.
        if (!habit.dates.containsKey(intFromDate(date.add(Duration(days: -1))))) break;
      } else {
        // If toady (i=0) is not checked it is OK
        if (i == 0) continue;
        break;
      }
    }

    return streak.toString();
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
    final int iteration = habit.dates[selectedDate.millisecondsSinceEpoch] ?? 0;

    if (isHabitChecked && habit.extendedGoal != null) {
      return Text("$iteration / ${habit.extendedGoal}");
    } else
      return habit.goal > 1 ? Text("$iteration / ${habit.goal}") : null;
  }

  Future OpenHabitEditor(BuildContext context) async {
    final bool response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenCreateHabit(
                  habitToBeEditted: habit,
                )));
    if (response) modelHabitList.initModel();
  }
  //=============> GETTERS & SETTERS <==============\\

  ModelHabitCard(this.habit, this.selectedDate) {
    initModel();
  }

  bool get isHabitChecked => _isHabitChecked;

  String get habitStreak => _habitStreak;

  Key get key => _key;
}
