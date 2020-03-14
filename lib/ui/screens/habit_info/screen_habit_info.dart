import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/view_models/model_habit_info.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:provider/provider.dart';

import 'sub_monthly_calendar.dart';

class ScreenHabitInfo extends StatelessWidget {
  final String habitKey;

  const ScreenHabitInfo(this.habitKey);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('To be'));
//    return ValueListenableBuilder<Box>(
//      valueListenable:
//          Hive.box(HIVE_BOX_HABITS).listenable(keys: [habitKey.toString()]),
//      builder: (context, box, child) {
//        final Habit habit = box.get(habitKey.toString()) as Habit;
//        return ProxyProvider0(
//          update: (_, __) => ModelHabitInfo(habit),
//          child: Scaffold(
//            appBar: AppBar(
//              leading: IconButton(
//                icon: Icon(Icons.chevron_left),
//                onPressed: () => Navigator.pop(context, true),
//              ),
//              title: Text(habit.name),
//            ),
//            body: _Main(),
//          ),
//        );
//      },
//    );
  }
}

class _Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [MonthlyCalender()],
    );
  }
}
