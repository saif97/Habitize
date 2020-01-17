import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/view_models/model_habit_info.dart';
import 'package:provider/provider.dart';

import 'monthly_calendar.dart';

class ScreenHabitInfo extends StatelessWidget {
  final Habit habit;

  ScreenHabitInfo(this.habit);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
			create: (_)=>ModelHabitInfo(habit),
      child: Scaffold(
        appBar: AppBar(
          title: Text(habit.name),
        ),
        body: _Main(),
      ),
    );
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
