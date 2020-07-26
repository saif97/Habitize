import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:kt_dart/kt.dart';

import '../../domain/core/enums.dart';
import '../../domain/habit/habit.dart';
import '../../domain/habit/i_habit_repo.dart';
import '../core/utils_firestore.dart';
import 'habit_firebase_dto.dart';

class CloudHabitRepo implements IHabitRepo {
  final Firestore _firestore;

  CloudHabitRepo(this._firestore);
  @override
  Future<Either<EnumFailureHabit, Unit>> create(Habit habit) async {
    try {
      final HabitFirebaseDto habitDto = HabitFirebaseDto.fromDomain(habit);
      final userDoc = await _firestore.userDoc();
      await userDoc.habitCollection.document(habitDto.id).setData(habitDto.toJson());
      return right(unit);
    } on PlatformException catch (e) {
      if (e.message.contains('PERMISSION_DENIED')) {
        return left(EnumFailureHabit.insufficientPermission);
      } else {
        return left(EnumFailureHabit.unexpected);
      }
    }
  }

  @override
  Future<Either<EnumFailureHabit, Unit>> delete(Habit habit) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<Either<EnumFailureHabit, KtList<Habit>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future instantiateDB() {
    // TODO: implement instantiateDB
    throw UnimplementedError();
  }

  @override
  Future<Either<EnumFailureHabit, Unit>> update(Habit habit) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
