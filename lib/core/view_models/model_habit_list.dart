import 'package:flutter/material.dart';

import '../../ui/screens/habit_list/sub_bottom_time_line.dart';
import '../../ui/screens/screen_create_habit/screen_habit_creator.dart';
import '../models/Habit.dart';
import '../serivces/db_api/db.dart';
import '../utils/functions.dart';
import '../utils/locator.dart';
import 'base_model.dart';

class ModelHabitList extends BaseModel {
  Habit? _majorHabit;
  List<Habit> _listHabits = [];

  DateTime _selectedDate = getTodayDate();

  List<Widget> bottomBarElements = [];
  bool _showAllHabits = true;

  final GlobalKey keyAnimatedList = GlobalKey<AnimatedListState>();
  final DB _db;

  ModelHabitList() : _db = locator<DB>();

  Future initModel() async {
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
        isAllChecked = _majorHabit!.utils.isHabitChecked(date);
      }

      bottomBarElements.add(TimeLineCircle(
        day,
        isAllChecked: isAllChecked,
      ));
    }
    bottomBarElements = List.from(bottomBarElements.reversed);
  }

  bool isShowHabitFor(List<HabitMode> selectedMode) {
    if (majorHabit == null) return true;
    return showAllHabits || majorHabit!.utils.isHabitChecked(selectedDate) || selectedMode.contains(HabitMode.major);
  }

  Future<Habit?> getMajorHabit() async {
    final List<Habit> listHabits = await _db.getAll();
    for (final eachHabit in listHabits) {
      if (eachHabit.mode == HabitMode.major) return eachHabit;
    }
    return null;
  }

  List<Habit> filterHabits({required List<HabitMode> habitMode, required bool showChecked}) {
    return (_listHabits.cast<Habit>()).where((habit) {
      final bool isHabitChecked = habit.utils.isHabitChecked(_selectedDate);
      return habitMode.contains(habit.mode) && isHabitChecked == showChecked;
    }).toList();
  }

  Future openHabitCreator(BuildContext context) async {
    final bool response =
        await Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenCreateHabit())) ?? false;
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

  Habit? get majorHabit => _majorHabit;

  set selectedDate(DateTime value) {
    assert(value.difference(getTodayDate()).inDays <= 0);
    _selectedDate = value;
    notifyListeners();
  }
}
