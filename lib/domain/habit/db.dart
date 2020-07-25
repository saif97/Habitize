import '../../infrastructure/habit/Habit_hive_dto.dart';

abstract class DB {
  Future instantiateDB();

  Future<bool> put(HabitHiveDto habit);

  Future<bool> update(HabitHiveDto habit);

  Future<HabitHiveDto> get(int id);

  Future<List<HabitHiveDto>> getAll();

  Future<bool> delete(String id);
}
