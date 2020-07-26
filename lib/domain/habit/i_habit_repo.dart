import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import '../core/enums.dart';
import 'habit.dart';

abstract class IHabitRepo {
  Future instantiateDB();

  Stream<Either<EnumFailureHabit, KtList<Habit>>> getAll();

  Future<Either<EnumFailureHabit, Unit>> create(Habit habit);

  Future<Either<EnumFailureHabit, Unit>> delete(Habit habit);

  Future<Either<EnumFailureHabit, Unit>> update(Habit habit);
}
