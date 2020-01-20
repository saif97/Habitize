import 'package:flutter/material.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:provider/provider.dart';


import 'core/utils/locator.dart';
import 'ui/screens/habit_list/screen_habit_list.dart';

Future main() async {
  runApp(SplashScreen());
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: locator<ModelHabitList>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeWid(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Text("Splash Screen"),
    );
  }
}
