import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/view_models/model_habit_info.dart';
import 'package:provider/provider.dart';

import 'sub_monthly_calendar.dart';

class ScreenHabitInfo extends StatelessWidget {
  final Habit habit;

  const ScreenHabitInfo(this.habit);

  @override
  Widget build(BuildContext context) {
//    return const Center(child: Text('To be'));
    return ProxyProvider0(
      update: (_, __) => ModelHabitInfo(habit),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context, true),
          ),
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
