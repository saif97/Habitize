import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kt_dart/collection.dart';

import '../../domain/core/enums.dart';
import '../../domain/habit/habit.dart';
import '../../domain/habit/i_habit_repo.dart';
import '../../domain/shared/constants.dart';
import 'Habit_hive_dto.dart';

class LocalHabitRepo implements IHabitRepo {
  Box _box;

  Future instantiateDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HabitHiveDtoAdapter());
    Hive.registerAdapter(HabitModeAdapter());

    _box = await Hive.openBox(HIVE_BOX_HABITS);
//  Hive.box(HIVE_BOX_HABITS).deleteFromDisk();
  }

  @override
  Future<Either<EnumFailureHabit, Unit>> create(Habit habit) async {
    await _box.put(habit.id.getOrCrash(), habit);
    return right(unit);
  }

  @override
  Future<Either<EnumFailureHabit, Unit>> update(Habit habit) async {
    await _box.put(habit.id.getOrCrash(), habit);
    return right(unit);
  }

  @override
  Future<Either<EnumFailureHabit, Unit>> delete(Habit habit) async {
    await _box.delete(id);
    return right(unit);
  }

  @override
  Stream<Either<EnumFailureHabit, KtList<Habit>>> getAll() async* {
    yield right(_box.values.toImmutableList());
  }
}
