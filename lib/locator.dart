import 'package:get_it/get_it.dart';

import 'domain/habit/i_habit_repo.dart';
import 'infrastructure/habit/local_habit_repo.dart';
import 'application/view_models/model_habit_list.dart';
import 'infrastructure/core/audio.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_DB_IMPLEMENTATION = false;
bool isLocatorInitialized = false;

Future setupLocator() async {
//  DB_API db_api = USE_FAKE_DB_IMPLEMENTATION ? Fake_DB_API() : Real_DB_API;
  AudioUtils utilsAudio = AudioUtils();

  final IHabitRepo db_api = LocalHabitRepo();
  await db_api.instantiateDB();

  ModelHabitList modelHabitList = ModelHabitList();

//  locator.register
  locator.registerLazySingleton(() => db_api);

  locator.registerLazySingleton(() => utilsAudio);
  locator.registerLazySingleton(() => modelHabitList);

  modelHabitList.initModel();

  return true;
}
