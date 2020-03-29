import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/serivces/db_api/db.dart';
import 'package:habitize3/core/utils/locator.dart';

class ModelHabitCreator {
	final TextEditingController _controller_name = TextEditingController();
	final TextEditingController _controller_when = TextEditingController();
	final TextEditingController _controller_reward = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  HabitMode habitMode = HabitMode.Bonus;
  final Habit _habitToBeEditted;
  int extendedGoal;
  int goal = 1;
  String when;
  String reward;

  ModelHabitCreator({Habit habit}) : _habitToBeEditted = habit {
    if (_habitToBeEditted != null) {
      _controller_name.text = _habitToBeEditted.name;
      habitMode = _habitToBeEditted.mode;
      goal = _habitToBeEditted.goal;
      extendedGoal = _habitToBeEditted.extendedGoal;
      when = _habitToBeEditted.when;
      reward = _habitToBeEditted.reward;
    }
  }

  Future<bool> submit(BuildContext context) async {
    if (globalKey.currentState.validate()) {
      final Habit habit =
          _habitToBeEditted ?? Habit(key: UniqueKey().toString());
      habit.name = _controller_name.text;
      habit.mode = habitMode;
      habit.goal = goal;
      habit.extendedGoal = extendedGoal;
      habit.when = _controller_when.text;
      habit.reward = _controller_reward.text;
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


	TextEditingController get controller_when => _controller_when;

	GlobalKey<FormState> get globalKey => _globalKey;

	TextEditingController get controller_reward => _controller_reward;
}
