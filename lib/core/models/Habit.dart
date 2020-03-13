import 'package:flutter/material.dart';
import 'package:habitize3/core/utils/audio.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'file:///L:/Flutter/Projects/habitize3/lib/core/serivces/db_api/habitUtils.dart';
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
  Map<int, int> dates;

  @HiveField(3)
  HabitMode mode;

  @HiveField(4)
  // number of iterations.
  int goal;

  Habit({this.dates, this.name, this.streak, this.goal, this.mode, this.key}) {
    dates = <int, int>{};
    _utils = HabitUtils(this);
  }

  HabitUtils get utils => _utils;
}