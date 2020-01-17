import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/view_models/model_habit_card.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:provider/provider.dart';

import 'habit_card.dart';

class HabitStream extends StatelessWidget {
  final List<Habit> listHabits;

  HabitStream(this.listHabits);

  @override
  Widget build(BuildContext context) {
    ModelHabitList model = Provider.of(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        ListView.builder(
            shrinkWrap: true,
            itemCount: listHabits.length,
            itemBuilder: (context, index) {
              Habit habit = listHabits[index];

              return ChangeNotifierProvider<ModelHabitCard>(
                  create: (context) =>
                      ModelHabitCard(habit, model.selectedDate),
                  child: HabitCard(habit));
            })
      ]),
    );
  }
}
