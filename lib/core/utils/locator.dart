import 'package:get_it/get_it.dart';
import 'package:habitize3/core/serivces/db_api/db.dart';
import 'package:habitize3/core/serivces/db_api/real_db.dart';
import 'package:habitize3/core/utils/audio.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_DB_IMPLEMENTATION = false;
bool isLocatorInitialized = false;

setupLocator() async {
//  DB_API db_api = USE_FAKE_DB_IMPLEMENTATION ? Fake_DB_API() : Real_DB_API;
  AudioUtils utilsAudio = AudioUtils();

  DB db_api = RealDB();
  await db_api.instantiateDB();

  ModelHabitList modelHabitList = ModelHabitList();
  modelHabitList.initModel();

  locator.registerLazySingleton(() => db_api);
  locator.registerLazySingleton(() => utilsAudio);
  locator.registerLazySingleton(() => modelHabitList);

  return true;
}
