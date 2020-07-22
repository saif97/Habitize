import 'package:get_it/get_it.dart';

import 'domain/habit/db.dart';
import 'infrastructure/habit/real_db.dart';
import 'application/view_models/model_habit_list.dart';
import 'infrastructure/core/audio.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_DB_IMPLEMENTATION = false;
bool isLocatorInitialized = false;

Future setupLocator() async {
//  DB_API db_api = USE_FAKE_DB_IMPLEMENTATION ? Fake_DB_API() : Real_DB_API;
  AudioUtils utilsAudio = AudioUtils();

  final DB db_api = RealHabitDB();
  await db_api.instantiateDB();

  ModelHabitList modelHabitList = ModelHabitList();

//  locator.register
  locator.registerLazySingleton(() => db_api);

  locator.registerLazySingleton(() => utilsAudio);
  locator.registerLazySingleton(() => modelHabitList);

  modelHabitList.initModel();

  return true;
}
