import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/serivces/db_api/db.dart';
import 'package:habitize3/core/utils/locator.dart';

class ModelHabitCreator {
  final TextEditingController _controller_name = TextEditingController();
  final Habit _habitToBeEditted;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  ModelHabitCreator({Habit habit}) : _habitToBeEditted = habit {
    if (_habitToBeEditted != null)
      _controller_name.text = _habitToBeEditted.name;
  }

  Future<bool> submit(BuildContext context,
      {int goal, HabitMode habitMode}) async {
    if (globalKey.currentState.validate()) {
      final Habit habit =
          _habitToBeEditted ?? Habit(key: UniqueKey().toString());
      habit.name = _controller_name.text;
      habit.mode = habitMode;
      habit.goal = goal;
      // If we're creating a new habit, a new key will be created. If we're
      // editing a habit, _habitToBeEditted's key will be used.

      await locator<DB>().put(habit);

      Navigator.pop(context, true);
      return true;
    }
    return false;
  }

//=============> GETTERS & SETTERS <==============\\
  TextEditingController get controller_name => _controller_name;

  GlobalKey<FormState> get globalKey => _globalKey;
}
