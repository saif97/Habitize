import '../../models/Habit.dart';

abstract class DB {
  Future instantiateDB();

  Future<bool> put(Habit habit);

  Future<bool> update(Habit habit);

  Future<Habit> get(int id);

  Future<List<Habit>> getAll();

  Future<bool> delete(String id);
}
