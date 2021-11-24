import 'package:Streak/ui/shared/shared_wids.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../../core/models/Habit.dart';
import '../../../core/utils/functions.dart';
import '../../../core/view_models/model_habit_creator.dart';
import '../../../core/view_models/model_habit_list.dart';
import '../../shared/constants.dart';

class ScreenCreateHabit extends StatelessWidget {
  final Habit? habitToBeEdited;

  const ScreenCreateHabit({this.habitToBeEdited});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModelHabitCreator>(
      create: (context) => ModelHabitCreator(habit: habitToBeEdited),
      child: Scaffold(
        appBar: AppBar(
          title: Text(habitToBeEdited == null ? "Create Habit" : "Edit Habit"),
        ),
        body: _Main(),
      ),
    );
  }
}

class _Main extends StatefulWidget {
  @override
  __MainState createState() => __MainState();
}

class __MainState extends State<_Main> {
  late final ModelHabitCreator _model;
  late final ModelHabitList _modelHabitList;
  List<bool> _listSelectedItems = [false, true];

  @override
  void initState() {
    _model = Provider.of(context);
    _modelHabitList = Provider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMajorHabitExist = _modelHabitList.majorHabit != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          Form(
            key: _model.globalKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter a Name';
                    }
                    return null;
                  },
                  controller: _model.controller_name,
                  maxLength: 40,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextFormField(
                  controller: _model.controller_when,
                  maxLength: 20,
                  decoration: const InputDecoration(labelText: 'when'),
                ),
                TextFormField(
                  controller: _model.controller_reward,
                  maxLines: 1,
                  maxLength: 20,
                  decoration: const InputDecoration(labelText: 'Reward'),
                ),
              ],
            ),
          ),
          Align(
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              isSelected: _listSelectedItems,
              onPressed: (int i) => setState(() {
                if (HabitMode.values[i] == HabitMode.major && isMajorHabitExist) {
                  utilsShowSnakeBar(context, 'Major habit exists', "You already have Major Habit");
                } else {
                  _listSelectedItems = [false, false];

                  _listSelectedItems[i] = true;
                  _model.habitMode = HabitMode.values[i];
                }
              }),
              children: HabitMode.values.map((f) => Text(strFromMode(f))).toList(),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Align(child: Text("Goal", style: getTextTheme(context).subtitle1))),
          SizedBox(
            height: 30,
            child: Align(
              child: NumberPicker(
                value: _model.goal,
                minValue: 1,
                maxValue: 100,
                onChanged: (val) => setState(() {
                  _model.goal = val;
                  _model.extendedGoal = _model.goal;
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(child: Text("Extended Goal", style: getTextTheme(context).subtitle1)),
          ),
          SizedBox(
            height: 30,
            child: Align(
              child: NumberPicker(
                value: _model.extendedGoal ?? _model.goal,
                minValue: _model.goal,
                maxValue: 100,
                onChanged: (val) => setState(() => _model.extendedGoal = val),
              ),
            ),
          ),
          Unsplash(),
          Align(
            child: ElevatedButton(
              onPressed: () => _model.submit(context),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}

class Unsplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ModelHabitCreator _model = Provider.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: _model.imgURL == null
          ? SizedBox(
              height: UNSPLASH_IMAGE_HEIGHT,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _model.openUnsplash(context),
                child: const Text("Tap to Choose Image"),
              ),
            )
          : InkWell(
              onTap: () => _model.openDialogAdjustImg(context),
              child: SharedCachedNetworkImage(url: _model.imgURL!, yAlignment: _model.imgY_Alignment),
            ),
    );
  }
}
