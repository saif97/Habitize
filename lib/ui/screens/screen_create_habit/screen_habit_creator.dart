import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/view_models/model_habit_creator.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/shared/constants.dart';
import 'package:habitize3/ui/shared/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ScreenCreateHabit extends StatelessWidget {
  final Habit habitToBeEditted;

  const ScreenCreateHabit({this.habitToBeEditted});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModelHabitCreator>(
      create: (context) => ModelHabitCreator(habit: habitToBeEditted),
      child: Scaffold(
        appBar: AppBar(
          title: Text(habitToBeEditted == null ? "Create Habit" : "Edit Habit"),
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
  bool isBonusHabit;
  ModelHabitCreator _model;
  ModelHabitList _modelHabitList;
  List<bool> _listSelectedItems = [false, true];
  final List<HabitMode> _listToggleOptions = List.of(HabitMode.values);

  @override
  Widget build(BuildContext context) {
    _model ??= Provider.of(context);
    _modelHabitList ??= Provider.of(context);

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
                    if (value.isEmpty) {
                      return 'Please Enter a Name';
                    }
                    return null;
                  },
                  controller: _model.controller_name,
                  maxLines: 1,
                  maxLength: 40,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextFormField(
                  controller: _model.controller_when,
                  maxLines: 1,
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
                if (_listToggleOptions[i] == HabitMode.Majror && isMajorHabitExist) {
                  CFlushBar(context, "You already have Majro Habit");
                  return;
                }
                _listSelectedItems = [false, false];

                _listSelectedItems[i] = true;
                _model.habitMode = _listToggleOptions[i];
              }),
              children: _listToggleOptions.map((f) => Text(strFromMode(f))).toList(),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Align(child: Text("Goal", style: getTextTheme(context).subtitle))),
          Container(
            height: 30,
            child: Align(
              child: NumberPicker.integer(
                initialValue: _model.goal,
                minValue: 1,
                maxValue: 100,
                scrollDirection: Axis.horizontal,
                listViewWidth: 150,
                itemExtent: 30,
                onChanged: (val) => setState(() {
                  _model.goal = val as int;
                  _model.extendedGoal = _model.goal;
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(child: Text("Extended Goal", style: getTextTheme(context).subtitle)),
          ),
          Container(
            height: 30,
            child: Align(
              child: NumberPicker.integer(
                initialValue: _model.extendedGoal ?? _model.goal,
                minValue: _model.goal,
                maxValue: 100,
                scrollDirection: Axis.horizontal,
                listViewWidth: 150,
                itemExtent: 30,
                highlightSelectedValue: true,
                onChanged: (val) => setState(() => _model.extendedGoal = val as int),
              ),
            ),
          ),
          Unsplash(),
          Align(
            child: RaisedButton(
              onPressed: () => _model.submit(context),
              color: Colors.green,
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
          ? Container(
              height: UNSPLASH_IMAGE_HEIGHT,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () => _model.openUnsplash(context),
                child: const Text("Tap to Choose Image"),
              ),
            )
          : InkWell(
              onTap: () => _model.openDialogAdgustImg(context),
              child: CCachedNetworkImage(url: _model.imgURL, yAligment: _model.imgY_Alignment),
            ),
    );
  }
}
