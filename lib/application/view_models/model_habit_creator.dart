import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../domain/habit/i_habit_repo.dart';
import '../../infrastructure/habit/Habit_hive_dto.dart';
import '../../locator.dart';
import '../../presentation/screen_create_habit/dialog_img.dart';
import '../../presentation/screen_unsplash_image.dart';
import 'base_model.dart';

class ModelHabitCreator extends BaseModel {
  final TextEditingController _controller_name = TextEditingController();
  final TextEditingController _controller_when = TextEditingController();
  final TextEditingController _controller_reward = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  HabitMode habitMode = HabitMode.Bonus;
  final HabitHiveDto _habitToBeEditted;
  int extendedGoal;
  int goal = 1;
  String when;
  String reward;
  String imgURL;
  double imgY_Alignment = 0;

  ModelHabitCreator({HabitHiveDto habit}) : _habitToBeEditted = habit {
    if (_habitToBeEditted != null) {
      _controller_name.text = _habitToBeEditted.name;
      habitMode = _habitToBeEditted.mode;
      goal = _habitToBeEditted.goal;
      extendedGoal = _habitToBeEditted.extendedGoal;
      when = _habitToBeEditted.when;
      reward = _habitToBeEditted.reward;
      imgURL = _habitToBeEditted.imgUrl;
      imgY_Alignment = _habitToBeEditted.imgY_Alignment;
    }
  }

  Future<bool> submit(BuildContext context) async {
    if (globalKey.currentState.validate()) {
      final HabitHiveDto habit = _habitToBeEditted ?? HabitHiveDto(key: UniqueKey().toString());
      habit.name = _controller_name.text;
      habit.mode = habitMode;
      habit.goal = goal;
      habit.extendedGoal = extendedGoal;
      habit.when = _controller_when.text;
      habit.reward = _controller_reward.text;
      habit.imgUrl = imgURL;
      habit.imgY_Alignment = imgY_Alignment;
      // If we're creating a new habit, a new key will be created. If we're
      // editing a habit, _habitToBeEditted's key will be used.

      await locator<IHabitRepo>().create(habit);

      Navigator.pop(context, true);
      return true;
    }
    return false;
  }

  Future openUnsplash(BuildContext context) async {
    imgURL =
        await Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenUnsplashImg()));
    logMessage(imgURL);
  }

  Future openDialogAdgustImg(BuildContext context) async {
    var r = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => DialogAdgustUnsplashImg(imgURL),
    );
    if (r.runtimeType == bool && r == true)
      imgURL = null;
    else
      imgY_Alignment = r as double;

    notifyListeners();
  }

//=============> GETTERS & SETTERS <==============\\
  TextEditingController get controller_name => _controller_name;

  TextEditingController get controller_when => _controller_when;

  GlobalKey<FormState> get globalKey => _globalKey;

  TextEditingController get controller_reward => _controller_reward;
}
