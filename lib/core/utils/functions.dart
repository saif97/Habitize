import 'package:habitize3/core/models/Habit.dart';
import 'package:intl/intl.dart';

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

void printData(Habit habit,
    {bool detailedDatesInfo = false, bool onlyThisMonth = true}) {
  String map = '';
  // sort the keys decending order to have latest days checked first printed.
  final List<int> listSortedKeys = habit.dates.cast<int,int>().keys.toList()
    ..sort((a, b) => b.compareTo(a));

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  for (final int dateInMill in listSortedKeys) {
    final int iteration = habit.dates.cast<int,int>()[dateInMill];

    if (detailedDatesInfo || ((!detailedDatesInfo) && iteration == 0)) {
      final date = DateTime.fromMillisecondsSinceEpoch(dateInMill);

      // only print dates from this month.
      if (onlyThisMonth &&
          date.isBefore(DateTime(DateTime.now().year, DateTime.now().month)))
        break;

      final formatedDateString = formatter.format(date);

      map += " \t $formatedDateString : $iteration , \n";
    }
  }

  habit.dates.forEach((k, v) {});
  String str = "---------- START ----------  \n"
      "ID: ${habit.key} \n"
      "Name: ${habit.name}\n"
      "Checked On:\n$map\n"
      "---------- END ----------  \n";
  print(str); // don't you dare deleting this line.
}

///Takes a habit and prints its the dates when the habit is checked.
void printThisMonthDates(Habit habit) {
  // sort the keys decending order to have latest days checked first printed.
  List<int> listSortedKeys = habit.dates.cast<int,int>().keys.toList()
    ..sort((a, b) => b.compareTo(a));
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  String map = "";
  listSortedKeys.forEach((dateInMill) {
    int iteration = habit.dates.cast<int,int>()[dateInMill];
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInMill);

    var formatedDateString = formatter.format(date);

    if (iteration > 0)
      map += " $formatedDateString : $iteration ,";
    else
      map += " $formatedDateString : Checked";

    if (!isDateZeroedAtDayStart(date)) map += " ---- Warning, Date is not Zeroed";
  });

  String str = "---------- START ----------  \n"
      "Name: ${habit.name}\n"
      "Checked days: $map\n"
      "---------- END ----------  \n";

  print(str); // don't you dare deleting this line.
}

bool isDateZeroedAtDayStart(DateTime date) {

  return date.microsecond == 0;
}
