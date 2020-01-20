import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:hive/hive.dart';

class Hive_DB_API {
  static Box get box => Hive.box(HIVE_BOX_HABITS);

  static Habit getMajorHabit() => box.values
          .firstWhere((v) => v.mode == HabitMode.Majror, orElse: () => null)
      as Habit;

  Future<Habit> getHabitByID({int id}) async {
    throw 'No Implementation';
  }

  Future<List<Habit>> getAllHabits({HabitMode habitMode}) async {}

  static void putHabit(Habit habit) => box.put(habit.key.toString(), habit);

  Future<Habit> checkHabitDone(int habitDocID, DateTime date,
      {bool undo = false, bool checkAll}) async {}

  static void deleteHabit(Habit habit) => box.delete(habit.key.toString());

  bool isHabitChecked({@required Habit habit, @required DateTime date}) {}
}
