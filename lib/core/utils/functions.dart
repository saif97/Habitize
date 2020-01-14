DateTime getTodayDate({Duration addDuration = Duration.zero}) {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day).add(addDuration);
}

int getTodayDateInt({Duration addDuration = Duration.zero}) =>
    getTodayDate(addDuration: addDuration).millisecondsSinceEpoch;
