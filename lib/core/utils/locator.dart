import 'package:get_it/get_it.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/serivces/db_api/fake_db_api.dart';
import 'package:habitize3/core/serivces/db_api/real_db_api.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_DB_IMPLEMENTATION = false;

setupLocator() async {
//  DB_API db_api = USE_FAKE_DB_IMPLEMENTATION ? Fake_DB_API() : Real_DB_API;
  DB_API db_api = DB_API();

  await db_api.init();

  locator.registerLazySingleton(() => db_api);
}
