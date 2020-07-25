import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../domain/habit/habitUtils.dart';

part 'Habit_hive_dto.g.dart';

// Make sure file name, class, and <part> are alls same case.
// run the command below to generate folders files.
// flutterS pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 2)
enum HabitMode {
  @HiveField(0)
  Majror,
  @HiveField(1)
  Bonus
}

@HiveType(typeId: 1)
class HabitHiveDto {
  HabitUtils _utils;
  @HiveField(0)
  @required
  final String key;

  @HiveField(1)
  @required
  String name;

// 100.580 there a{ 46
  @Deprecated('Calculate it on runtime is more maintainalbe')
  final int streak;

  @HiveField(2)
  HabitMode mode;

  @HiveField(3)
  // number of iterations.
  int goal;

  @HiveField(4)
  // @protected 
  Map<int, int> dates;
  @HiveField(5)
  int extendedGoal;

  @HiveField(6)
  String when;

  @HiveField(7)
  String reward;

  @HiveField(8)
  String imgUrl;

  @HiveField(9)
  double imgY_Alignment;

  HabitHiveDto({
    this.dates,
    this.name,
    this.streak,
    this.goal,
    this.mode,
    this.key,
    this.reward,
    this.when,
    this.extendedGoal,
  }) {
    dates ??= <int, int>{};
    _utils = HabitUtils(this);
  }

  HabitUtils get utils => _utils;

//=============> GETTERS & SETTERS <==============\\

}
