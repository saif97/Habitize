import 'package:habitize3/core/models/habit.dart';

DateTime getTodayDate({Duration addDuration = Duration.zero}) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day).add(addDuration);
}

int getTodayDateInt({Duration addDuration = Duration.zero}) =>
    getTodayDate(addDuration: addDuration).millisecondsSinceEpoch;

HabitMode modeFromString(String str) =>
    HabitMode.values.firstWhere((e) => e.toString() == str);

String strFromMode(HabitMode habitMode) {
  switch (habitMode) {
    case HabitMode.Bonus:
      return "Bonus";
    case HabitMode.Majror:
      return "Major";
  }
}
