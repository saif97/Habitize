import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/view_models/model_habit_creator.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ScreenCreateHabit extends StatelessWidget {
  Habit habitToBeEditted;

  ScreenCreateHabit({this.habitToBeEditted});

  @override
  Widget build(BuildContext context) {
    return Provider<ModelHabitCreator>(
      create: (context) => ModelHabitCreator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Habit"),
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
  int goal = 1;
  ModelHabitCreator _model;
  ModelHabitList _modelHabitList;
  List<bool> _listSelectedItems;
  List<HabitMode> _listToggleOptions = List.of(HabitMode.values);

  HabitMode selectedMode = HabitMode.Bonus;

  @override
  Widget build(BuildContext context) {
    _model ??= Provider.of(context);
    _modelHabitList ??= Provider.of(context);

    var isMajroHabitExist = _modelHabitList.majorHabit == null;
    _listSelectedItems = List.filled(isMajroHabitExist ? 1 : 2, false);

    if (isMajroHabitExist) _listToggleOptions.remove(HabitMode.Majror);

    print("=========toggle=========");
    print(_listSelectedItems);
    print(_listToggleOptions);
    print("==================");

    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Form(
            key: _model.globalKey,
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter a Name';
                }
                return null;
              },
              controller: _model.controller_name,
              maxLines: 1,
              maxLength: 40,
              decoration: InputDecoration(labelText: 'name'),
            ),
          ),
          Align(
            child: ToggleButtons(
                borderRadius: BorderRadius.circular(10),
                isSelected: _listSelectedItems,
                children: _listToggleOptions
                    .map((f) => Text(strFromMode(f)))
                    .toList(),
                onPressed: (int i) => setState(() {
                      _listSelectedItems[i] = true;
                      selectedMode = _listToggleOptions[i];
                    })),
          ),
          Align(
            child: NumberPicker.integer(
              initialValue: goal,
              minValue: 1,
              maxValue: 100,
              scrollDirection: Axis.horizontal,
              listViewWidth: 150,
              itemExtent: 30,
              onChanged: (val) => setState(() => goal = val),
            ),
          ),
          Align(
            child: RaisedButton(
              onPressed: () =>
                  _model.submit(context, goal: goal, habitMode: selectedMode),
              child: Text('Done'),
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
