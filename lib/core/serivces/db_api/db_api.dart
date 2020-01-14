import 'dart:async';

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

  Future<List<Habit>> getAllHabits() async {
    var listRecords = await SembastUtils.store.find(dbSembast);

    List<Habit> listHabits = listRecords.map((record) {
      return Habit.fromMap(record.value, record.key);
    }).toList();
    return listHabits;
  }

  Future storeHabit(
      String name, bool isBonuseHabit, int importance, int goal) async {
    await SembastUtils.store.add(dbSembast, {
      HABIT_NAME: name,
      HABIT_STREAK: 0,
      HABIT_IS_BONUS: isBonuseHabit,
      HABIT_MODE: importance,
      HABIT_GOAL: goal
    });
  }

  void updateHabit(Habit habit) async {
    await SembastUtils.store.record(habit.id).update(dbSembast, habit.toMap());
    getAllHabits();
  }

  Future checkHabitDone(int habitDocID, DateTime date,
      {bool undo = false, bool checkAll}) async {
    int dateInt = date.millisecondsSinceEpoch;
    var record = SembastUtils.store.record(habitDocID);
    Map map = await record.get(dbSembast);

    Habit habit = Habit.fromMap(map, habitDocID);

    habit.dates[dateInt] ??= habit.goal;

    if (checkAll != null) {
      if (checkAll)
        habit.dates[dateInt] = 0;
      else
        habit.dates[dateInt] =
            habit.goal; // reset habit iteration if unCheck all is pressed
    } else {
      undo ? habit.dates[dateInt]++ : habit.dates[dateInt]--;
    }

    Map<String, int> r = Map();

    habit.dates.forEach((k, v) {
      r.addAll({k.toString(): v});
    });

    await record.update(dbSembast, {
      HABIT_DATES: r,
    });
    getAllHabits();

//    if (habit.dates[dateInt] == 0)
//      _audio.playSoundAllChecked();
//    else
//      _audio.playSoundIterationChecked();
  }

  void deleteHabit(int habitID) async {
    await SembastUtils.store.record(habitID).delete(dbSembast);
    getAllHabits();
  }

  bool isHabitChecked({Habit habit, DateTime date}) {
    if (date == null) date = getTodayDate();
    return habit.dates[date.millisecondsSinceEpoch] == 0;
  }

  Future<Habit> getMajorHabit() async {
    var finder = Finder(filter: Filter.equals(HABIT_MODE, 0));
    var record = await SembastUtils.store.findFirst(dbSembast, finder: finder);
    if (record == null)
      return null;
    else
      return Habit.fromMap(record.value, record.key);
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
