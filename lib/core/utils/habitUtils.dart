import '../models/Habit.dart';
import '../serivces/db_api/db.dart';
import 'audio.dart';
import 'functions.dart';
import 'locator.dart';

class HabitUtils {
  final Habit _habit;

  HabitUtils(this._habit);

  bool isHabitCheckedToday() => isHabitChecked(getTodayDate());

  bool isHabitChecked(DateTime date) => (_habit.dates[date.millisecondsSinceEpoch] ?? 0) >= _habit.goal;

  bool isExtendedGoalChecked(DateTime date) {
    if (_habit.extendedGoal != null && _habit.dates[date.millisecondsSinceEpoch] != null) {
      return _habit.dates[date.millisecondsSinceEpoch]! >= _habit.extendedGoal!;
    } else
      return false;
  }

  Future checkHabit(DateTime date, {bool checkAll = false}) async {
    final int dateInt = date.millisecondsSinceEpoch;
    final AudioUtils _audioUtils = locator<AudioUtils>();
    _habit.dates[dateInt] ??= 0;
    if (checkAll)
      _habit.dates[dateInt] = _habit.goal;
    else
      _habit.dates[dateInt] = (_habit.dates[dateInt] ?? 0) + 1;

    await locator<DB>().update(_habit);

    if (_habit.dates[dateInt] == _habit.goal)
      _audioUtils.playSoundAllChecked();
    else
      _audioUtils.playSoundIterationChecked();
  }

  Future resetIteration(DateTime date) async {
    final int dateInt = date.millisecondsSinceEpoch;
    _habit.dates[dateInt] = _habit.goal;
    await locator<DB>().update(_habit);
  }

  List<int> getListCheckedDatesKeys({bool sorted = true}) {
    // sort the keys decending order to have latest days checked first printed.
    final List<int> listKeys = _habit.dates.keys.toList(growable: false);

    if (sorted) listKeys.sort((a, b) => b.compareTo(a));

    return listKeys;
  }
}
