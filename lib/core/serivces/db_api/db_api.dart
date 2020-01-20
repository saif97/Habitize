import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/utils/audio.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB_API {
  final UtilsAudio _audio;

  DB_API(this._audio);

  Database dbSembast;

  SembastUtils sembastUtils;

  Future init() async {
    sembastUtils = SembastUtils._();

    dbSembast = await SembastUtils.instance.database;
  }

  Future<Habit> getHabitByID({int id}) async =>
      Habit.fromMap(await SembastUtils.store.record(id).get(dbSembast), id);

  Future<List<Habit>> getAllHabits({HabitMode habitMode}) async {
    Finder finder;
    if (habitMode != null)
      finder = Finder(filter: Filter.equals(HABIT_MODE, habitMode.toString()));

    final listRecords =
        await SembastUtils.store.find(dbSembast, finder: finder);


    if (listRecords.isEmpty) return null;
    final List<Habit> listHabits = listRecords.map((record) {
      return Habit.fromMap(record.value, record.key);
    }).toList();
    return listHabits;
  }

  Future storeHabit2(Habit habit) async {
    await SembastUtils.store.add(dbSembast, {
      HABIT_NAME: habit.name,
      HABIT_STREAK: 0,
      HABIT_MODE: habit.mode.toString(),
      HABIT_GOAL: habit.goal
    });
  }

  Future updateHabit(Habit habit) async =>
      SembastUtils.store.record(habit.id).update(dbSembast, habit.toMap());

  Future<Habit> checkHabitDone(int habitDocID, DateTime date,
      {bool undo = false, bool checkAll}) async {
    final int dateInt = date.millisecondsSinceEpoch;
    final record = SembastUtils.store.record(habitDocID);
    Map map = await record.get(dbSembast);

    final Habit habit = Habit.fromMap(map, habitDocID);

    habit.dates[dateInt] ??= habit.goal;

    if (checkAll != null) {
      if (checkAll)
        habit.dates[dateInt] = 0;
      else
        habit.dates[dateInt] =
            habit.goal; // reset habit iteration if unCheck all is pressed
    } else
      undo ? habit.dates[dateInt]++ : habit.dates[dateInt]--;

    Map<String, int> r = <String, int>{};

    habit.dates.forEach((k, v) {
      r.addAll({k.toString(): v});
    });

    final Map updatedHabitMap = await record.update(dbSembast, {
      HABIT_DATES: r,
    });

    if (habit.dates[dateInt] == 0)
      _audio.playSoundAllChecked();
    else
      _audio.playSoundIterationChecked();

    return Habit.fromMap(updatedHabitMap, habitDocID);
  }

  Future deleteHabit(int habitID) async {
    await SembastUtils.store.record(habitID).delete(dbSembast);
    getAllHabits();
  }

  bool isHabitChecked({@required Habit habit, @required DateTime date}) {
    date ??= getTodayDate();
    return habit.dates[date.millisecondsSinceEpoch] == 0;
  }
}

class SembastUtils {
  SembastUtils._();

  static var store = intMapStoreFactory.store('habits');

  static final SembastUtils _singleton = SembastUtils._();

  static SembastUtils get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();

    final dbPath = join(appDocumentDir.path, 'demo.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter.complete(database);
  }
}
