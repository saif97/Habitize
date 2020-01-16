import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_card.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:provider/provider.dart';

import 'habit_card.dart';

class HabitStream extends StatelessWidget {
  DB_API api = locator();
  final bool showCheckedHabits;
  final int habitMode;

  HabitStream({this.showCheckedHabits = false, this.habitMode});

  @override
  Widget build(BuildContext context) {
    ModelHabitList model = Provider.of(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        ListView.builder(
            shrinkWrap: true,
            itemCount: model.listHabits.length,
            itemBuilder: (context, index) {
              Habit habit = model.listHabits[index];
              bool isHabitChecked =
                  api.isHabitChecked(habit: habit, date: model.selectedDate);

//              if (habitMode != null && habit.mode != habitMode)
//                return Container();
//
//              // showCheckedHabits is null then show all habits regardless of weither they're checked or not.
//
//              // if habit is checked and I don't want to show checked habits.
//              if (isHabitChecked && !showCheckedHabits)
//                return Container();
//              // if habit is not checked and I only want to show checked habits.
//              else if (!isHabitChecked && showCheckedHabits) return Container();

							print("=========hello=========");
							print(habit);
              return ChangeNotifierProvider<ModelHabitCard>(
                  create: (context) =>
                      ModelHabitCard(habit, model.selectedDate),
                  child: HabitCard(habit));
            })
      ]),
    );
  }
}
