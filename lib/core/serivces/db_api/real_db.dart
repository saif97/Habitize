import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../ui/shared/constants.dart';
import '../../models/Habit.dart';
import 'db.dart';

class RealHabitDB implements DB {
  late final Box _box;

  @override
  Future instantiateDB() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(HabitModeAdapter());

    _box = await Hive.openBox(HIVE_BOX_HABITS);
//  Hive.box(HIVE_BOX_HABITS).deleteFromDisk();
  }

  @override
  Future<bool> put(Habit habit) async {
    await _box.put(habit.key.toString(), habit);
    return true;
  }

  @override
  Future<bool> update(Habit habit) async {
    await _box.put(habit.key.toString(), habit);
    return true;
  }

  @override
  Future<bool> delete(String id) async {
    await _box.delete(id);
    return true;
  }

  @override
  Future<Habit> get(int id) async {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Habit>> getAll() async => _box.values.toList().cast<Habit>();
}
