import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB_API {
  Database dbSembast;

  StreamUtils streamUtils;
  SembastUtils sembastUtils;

  List<Habit> _listHabits;

  List<Habit> get listHabits => _listHabits;

  AudioCache audioPlayer;

  Future init() async {
    print("=========init done=========");
    streamUtils = StreamUtils._();
    sembastUtils = SembastUtils._();

    dbSembast = await SembastUtils.instance.database;
    audioPlayer = AudioCache();
  }

  void streamAllHabits() async {
    var listRecords = await SembastUtils.store.find(dbSembast);

    List<Habit> listHabits = listRecords.map((record) {
      return Habit.fromMap(record.value, record.key);
    }).toList();
    _listHabits = listHabits;
    streamUtils.addEvent(listHabits);
  }

  Stream get stream => streamUtils._controller.stream;

  void storeHabit(
      String name, bool isBonuseHabit, int importance, int goal) async {
    await SembastUtils.store.add(dbSembast, {
      HABIT_NAME: name,
      HABIT_STREAK: 0,
      HABIT_IS_BONUS: isBonuseHabit,
      HABIT_MODE: importance,
      HABIT_GOAL: goal
    });
    streamAllHabits();
  }

  void updateHabit(Habit habit) async {
    await SembastUtils.store.record(habit.id).update(dbSembast, habit.toMap());
    streamAllHabits();
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
    streamAllHabits();

    if (habit.dates[dateInt] == 0)
      audioPlayer.play("check.mp3");
    else
      audioPlayer.play("iteration_check.mp3");
  }

  void deleteHabit(int habitID) async {
    await SembastUtils.store.record(habitID).delete(dbSembast);
    streamAllHabits();
  }

  bool isHabitChecked({Habit habit, DateTime date}) {
    if (date == null) date = getTodayDate();
    return habit.dates[date.millisecondsSinceEpoch] == 0;
  }

  DateTime getTodayDate({Duration addDuration = Duration.zero}) {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day).add(addDuration);
  }

  int getTodayDateInt({Duration addDuration = Duration.zero}) =>
      getTodayDate(addDuration: addDuration).millisecondsSinceEpoch;

  Future<Habit> getMajorHabit() async {
    var finder = Finder(filter: Filter.equals(HABIT_MODE, 0));
    var record = await SembastUtils.store.findFirst(dbSembast, finder: finder);
    if (record == null)
      return null;
    else
      return Habit.fromMap(record.value, record.key);
  }

  DB_API();
}

class StreamUtils {
  StreamUtils._();

  StreamController<List<Habit>> _controller = StreamController.broadcast();

  void addEvent(List<Habit> e) {
    _controller.add(e);
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
