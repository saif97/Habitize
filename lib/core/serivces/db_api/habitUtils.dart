import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:hive/hive.dart';

import '../../utils/audio.dart';
import '../../utils/locator.dart';

class HabitUtils {
  final Habit _habit;

  HabitUtils(this._habit);

  bool isHabitChecked(DateTime date) {
    date ??= getTodayDate();
    return _habit.dates[date.millisecondsSinceEpoch] == 0;
  }

  void checkHabitDone(DateTime date, {bool undo = false, bool checkAll}) {
    final int dateInt = date.millisecondsSinceEpoch;

    _habit.dates[dateInt] ??= _habit.goal;

    if (checkAll != null) {
      if (checkAll)
        _habit.dates[dateInt] = 0;
      else
        // reset habit iteration if unCheck all is pressed
        _habit.dates[dateInt] = _habit.goal;
    } else
      undo ? _habit.dates[dateInt]++ : _habit.dates[dateInt]--;

    final Map<String, int> r = <String, int>{};

    _habit.dates.forEach((k, v) {
      r.addAll({k.toString(): v});
    });

    Hive.box(HIVE_BOX_HABITS).put(_habit.key.toString(), this);

    final AudioUtils audioUtils = locator<AudioUtils>();
    if (_habit.dates[dateInt] == 0) {
      audioUtils.playSoundAllChecked();
    } else
      audioUtils.playSoundIterationChecked();
  }
}
