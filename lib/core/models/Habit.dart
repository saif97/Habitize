import 'package:flutter/material.dart';
import 'package:habitize3/core/utils/habitUtils.dart';
import 'package:hive/hive.dart';

part 'Habit.g.dart';

// Make sure file name, class, and <part> are alls same case.
// run the command below to generate folders files.
// flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 2)
enum HabitMode {
  @HiveField(0)
  Majror,
  @HiveField(1)
  Bonus
}

@HiveType(typeId: 1)
class Habit {
  HabitUtils _utils;
  @HiveField(0)
  @required
  final String key;

  @HiveField(1)
  @required
  String name;

  @Deprecated('Calculate it on runtime is more maintainalbe')
  final int streak;

  @HiveField(2)
  HabitMode mode;

  @HiveField(3)
  // number of iterations.
  int goal;

  @HiveField(4)
  Map dates;

  Habit({this.dates, this.name, this.streak, this.goal, this.mode, this.key}) {
    dates ??= <int, int>{};
    _utils = HabitUtils(this);
  }

  HabitUtils get utils => _utils;
}
