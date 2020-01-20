import 'package:flutter/material.dart';
import 'package:habitize3/core/serivces/db_api/hive_db.dart';
import 'package:habitize3/core/utils/audio.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:hive/hive.dart';

part 'Habit.g.dart';

@HiveType(typeId: 2)
enum HabitMode {
  @HiveField(0)
  Majror,
  @HiveField(1)
  Bonus
}

@HiveType(typeId: 1)
class Habit {
	@HiveField(0)
  @required
  final Key key = UniqueKey();

  @HiveField(1)
  @required
  String name;

  @Deprecated('Calculate it on runtime is more maintainalbe')
  final int streak;

  @HiveField(2)
  Map<int, int> dates;

  @HiveField(3)
  HabitMode mode;

  @HiveField(4)
  // number of iterations.
  int goal;

  Habit({this.dates, this.name, this.streak, this.goal, this.mode}) {
    dates ??= <int, int>{};
  }

  bool isHabitChecked(DateTime date) {
    date ??= getTodayDate();
    return dates[date.millisecondsSinceEpoch] == 0;
  }

  void checkHabitDone(DateTime date, {bool undo = false, bool checkAll}) {
    final int dateInt = date.millisecondsSinceEpoch;

    dates[dateInt] ??= goal;

    if (checkAll != null) {
      if (checkAll)
        dates[dateInt] = 0;
      else
        dates[dateInt] =
            goal; // reset habit iteration if unCheck all is pressed
    } else
      undo ? dates[dateInt]++ : dates[dateInt]--;

    Map<String, int> r = <String, int>{};

    dates.forEach((k, v) {
      r.addAll({k.toString(): v});
    });

		Hive.box(HIVE_BOX_HABITS).put(key.toString(), this);

    AudioUtils audioUtils = locator<AudioUtils>();
    if (dates[dateInt] == 0) {
      audioUtils.playSoundAllChecked();
    } else
      audioUtils.playSoundIterationChecked();
  }
}
