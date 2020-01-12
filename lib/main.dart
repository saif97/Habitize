import 'package:flutter/material.dart';
import 'file:///L:/Flutter/Projects/habitize3/lib/ui/screens/screen_habit_list/screen_habit_list.dart';
import 'package:habitize3/ui/shared/widgets.dart';

import 'core/utils/locator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FutureBuilder(
        future: setupLocator(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done ) {
            return HomeWid();
          } else
            return CProgressIndecator();
        },
      ),
    );
  }
}
