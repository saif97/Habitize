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
			_habit.dates[date.millisecondsSinceEpoch] == 0;


	Future checkHabitDone(DateTime date, {bool undo = false, bool checkAll}) async {
		final int dateInt = date.millisecondsSinceEpoch;

//		_habit.dates[dateInt] ??= _habit.goal;
//		DateTime.fromMicrosecondsSinceEpoch(1584392400000000)
		if (checkAll != null) {
			if (checkAll)
				_habit.dates[dateInt] = 0;
			else
				// reset habit iteration if unCheck all is pressed
				_habit.dates[dateInt] = _habit.goal;
		} else
			undo ? _habit.dates[dateInt]++ : _habit.dates[dateInt]--;

		await locator<DB>().update(_habit);
		final AudioUtils audioUtils = locator<AudioUtils>();
		if (_habit.dates[dateInt] == 0) {
			audioUtils.playSoundAllChecked();
		} else
			audioUtils.playSoundIterationChecked();
	}
}
