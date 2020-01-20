import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:provider/provider.dart';

class ModelHabitCreator {
  final DB_API _db_api = locator<DB_API>() ;
  final TextEditingController _controller_name = TextEditingController();
  final Habit _habitToBeEditted;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  ModelHabitCreator({Habit habit}) : _habitToBeEditted = habit {
    if (_habitToBeEditted != null)
      _controller_name.text = _habitToBeEditted.name;
  }

  Future<bool> submit(BuildContext context,
      {int goal, HabitMode habitMode }) async {
    if (globalKey.currentState.validate()) {
      final Habit habit = _habitToBeEditted ?? Habit();
      habit.name = _controller_name.text;
      habit.mode = habitMode;
      habit.goal = goal;

      // Update the habit.
      _habitToBeEditted != null
          ? await _db_api.updateHabit(habit)
          : await _db_api.storeHabit2(habit);

      final ModelHabitList model = Provider.of(context, listen: false);
      await model.initModel();
      Navigator.pop(context);
      return true;
    }
    return false;
  }

//=============> GETTERS & SETTERS <==============\\
  TextEditingController get controller_name => _controller_name;

  GlobalKey<FormState> get globalKey => _globalKey;

}
