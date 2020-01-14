import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/shared/widgets.dart';
import 'package:provider/provider.dart';

class ModelHabitCreator {
  DB_API _db_api = locator();
  TextEditingController _controller_name = TextEditingController();
  Habit _habitToBeEditted;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  ModelHabitCreator({habit}) : _habitToBeEditted = habit {
    if (_habitToBeEditted != null)
      _controller_name.text = _habitToBeEditted.name;
  }

  Future<bool> submit(BuildContext context, {int goal}) async {
    if (globalKey.currentState.validate()) {
      // Update the habit.
      if (_habitToBeEditted != null) {
        var habit = _habitToBeEditted;
        habit.name = _controller_name.text;
        habit.mode = 1;
        habit.goal = goal;

        _db_api.updateHabit(habit);
        Navigator.pop(context);
        return true;
      }

      // create new habit.
      Habit habitMajor = await _db_api.getMajorHabit();
      if (habitMajor != null) {
        CFlushBar(context, "You already have a major habit.");
        return false;
      }
      await _db_api.storeHabit(_controller_name.text, false, 1, goal);
      ModelHabitList model =
          Provider.of<ModelHabitList>(context, listen: false);
			print("=========before =========");

      await model.initModel();
      print("=========done addition=========");
      Navigator.pop(context);
    }
  }

//=============> GETTERS & SETTERS <==============\\
  TextEditingController get controller_name => _controller_name;

  GlobalKey<FormState> get globalKey => _globalKey;
}
