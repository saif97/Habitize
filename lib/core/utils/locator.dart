import 'package:get_it/get_it.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/audio.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_DB_IMPLEMENTATION = false;
bool isLocatorInitialized = false;

setupLocator() async {
//  DB_API db_api = USE_FAKE_DB_IMPLEMENTATION ? Fake_DB_API() : Real_DB_API;
  UtilsAudio utilsAudio = UtilsAudio();

  DB_API db_api = DB_API(utilsAudio);
  await db_api.init();
  locator.registerLazySingleton(() => db_api);

  ModelHabitList modelHabitList = ModelHabitList();
  await modelHabitList.initModel();

  locator.registerLazySingleton(() => utilsAudio);
  locator.registerLazySingleton(() => modelHabitList);

  return true;
}
