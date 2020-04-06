import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/serivces/db_api/db.dart';
import 'package:habitize3/core/utils/functions.dart';

import 'audio.dart';
import 'locator.dart';

class HabitUtils {
  final Habit _habit;

  HabitUtils(this._habit);

  bool isHabitCheckedToday() => isHabitChecked(getTodayDate());

  bool isHabitChecked(DateTime date) =>
      (_habit.dates[date.millisecondsSinceEpoch] ?? 0) >= _habit.goal;

  bool isExtendedGoalChecked(DateTime date) =>
      _habit.dates[date.millisecondsSinceEpoch] >= _habit.extendedGoal;

  Future checkHabit(DateTime date, {bool checkAll}) async {
    final int dateInt = date.millisecondsSinceEpoch;
    final AudioUtils _audioUtils = locator<AudioUtils>();
		_habit.dates[dateInt] ??=0;
    if (checkAll)
      _habit.dates[dateInt] = _habit.goal;
    else
			_habit.dates[dateInt] ++;

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

  List<int> getListCheckedDatesKeys({bool sorted=true}){
		// sort the keys decending order to have latest days checked first printed.
		List<int> listKeys = _habit.dates.keys.toList(growable: false);

		if(sorted)
				 listKeys.sort((a, b) => b.compareTo(a));

		return listKeys;
	}
}
