import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/habit/db.dart';
import '../../domain/shared/constants.dart';
import 'Habit_hive_dto.dart';


class RealHabitDB implements DB {
  Box _box;

  Future instantiateDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HabitHiveDtoAdapter());
    Hive.registerAdapter(HabitModeAdapter());

    _box = await Hive.openBox(HIVE_BOX_HABITS);
//  Hive.box(HIVE_BOX_HABITS).deleteFromDisk();
  }

  @override
  Future<bool> put(HabitHiveDto habit) async {
    await _box.put(habit.key.toString(), habit);
    return true;
  }

  @override
  Future<bool> update(HabitHiveDto habit) async {
    await _box.put(habit.key.toString(), habit);
    return true;
  }

  @override
  Future<bool> delete(String id) async {
    await _box.delete(id);
    return true;
  }

  @override
  Future<HabitHiveDto> get(int id) async {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<HabitHiveDto>> getAll() async => _box.values.toList().cast<HabitHiveDto>();
}
