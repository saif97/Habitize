import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/serivces/db_api/db.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/ui/screens/habit_list/sub_bottom_time_line.dart';
import 'package:habitize3/ui/screens/screen_habit_creator.dart';

import '../utils/functions.dart';
import 'base_model.dart';

class ModelHabitList extends BaseModel {
  Habit _majorHabit;
  List<Habit> _listHabits;

  DateTime _selectedDate = getTodayDate();

  List<Widget> bottomBarElements;
  bool _showAllHabits = true;

  final GlobalKey keyAnimatedList = GlobalKey<AnimatedListState>();
  DB _db;

  Future initModel() async {
    _db = locator<DB>();
    _listHabits = await _db.getAll();
    _majorHabit = await getMajorHabit();

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

      bool isAllChecked = false;
      if (_majorHabit != null) {
        final DateTime date = getTodayDate().subtract(Duration(days: indexDay));
        isAllChecked = _majorHabit.utils.isHabitChecked(date);
      }

      bottomBarElements.add(TimeLineCircle(
        day,
        isAllchecked: isAllChecked,
      ));
    }
    bottomBarElements = List.from(bottomBarElements.reversed);
  }

  bool isShowHabitFor(List<HabitMode> selectedMode) {
    if (majorHabit == null) return true;
    return showAllHabits ||
        majorHabit.utils.isHabitChecked(selectedDate) ||
        selectedMode.contains(HabitMode.Majror);
  }

  Future<Habit> getMajorHabit() async {
    final List<Habit> listHabits = await _db.getAll();
    return listHabits.firstWhere((v) => v.mode == HabitMode.Majror,
        orElse: () => null);
  }

  List<Habit> filterHabits({
    List<HabitMode> habitMode,
    @required bool showChecked,
  }) {
    return (_listHabits.cast<Habit>())?.where((habit) {
          final bool isHabitChecked = habit.utils.isHabitChecked(_selectedDate);
          return habitMode.contains(habit.mode) &&
              isHabitChecked == showChecked;
        })?.toList() ??
        [];
  }

  Future openHabitCreator(BuildContext context) async {
    final bool response = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ScreenCreateHabit())) ??
        false;
    if (response) await initModel();
  }

  Future hideBounusAllAfter(int sec) async {
    await Future.delayed(Duration(seconds: sec));
    showAllHabits = false;
  }

  //=============> GETTER & SETTERS <==============\\

  bool get showAllHabits => _showAllHabits;

  set showAllHabits(bool value) {
    if (value == _showAllHabits) return;
    if (value == true) hideBounusAllAfter(10);
    _showAllHabits = value;
    notifyListeners();
  }

  DateTime get selectedDate => _selectedDate;

  Habit get majorHabit => _majorHabit;

  set selectedDate(DateTime value) {
    assert(value.difference(getTodayDate()).inDays <= 0);
    _selectedDate = value;
    notifyListeners();
  }

  set listHabits(List<Habit> value) {
    if (value == _listHabits) return;
    print("pot");
    _listHabits = value;
    notifyListeners();
  }
}
