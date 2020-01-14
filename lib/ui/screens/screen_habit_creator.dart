import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/view_models/model_habit_creator.dart';
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
        body: ChangeNotifierProvider<_ProviderModel>.value(
          value: _ProviderModel(0, editedHabit: habitToBeEditted),
          child: _Main(),
        ),
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
  ModelHabitCreator model;
  List<bool> _listSelectedItems = List.filled(2, false);
  List<String> _listToggleOptions = ['Major', 'Bonus'];

  @override
  Widget build(BuildContext context) {
    model ??= Provider.of(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Form(
            key: model.globalKey,
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter a Name';
                }
                return null;
              },
              controller: model.controller_name,
              maxLines: 1,
              maxLength: 40,
              decoration: InputDecoration(labelText: 'name'),
            ),
          ),
//          ToggleButtons(
//              borderRadius: BorderRadius.circular(10),
//              isSelected: _listSelectedItems,
//              children: _listToggleOptions.map((f) => Text(f)).toList(),
//              onPressed: (int i) => setState(() {
//                    _listSelectedItems[i] = true;
//                    selectedCondition = listToggleButtons[i];
//                  })),
//					Align(
//						child: Padding(
//							padding: const EdgeInsets.all(20),
//							child: ToggleSwitch(
//								options: ['Major', 'Bonus'],
//								),
//							),
//						),
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
              onPressed: () => model.submit(context, goal: goal),
              child: Text('Done'),
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}

//class ToggleSwitch extends StatefulWidget {
//	List<String> options;
//
//	ToggleSwitch({this.options});
//
//	@override
//	_ToggleSwitchState createState() => _ToggleSwitchState();
//}
//
//class _ToggleSwitchState extends State<ToggleSwitch> {
//	@override
//	Widget build(BuildContext context) {
//		return Container(
//			decoration: BoxDecoration(
//					border: Border.all(width: 1, color: Colors.green),
//					borderRadius: BorderRadius.all(Radius.circular(5))),
//			child: Wrap(
//				children: <Widget>[
//					for (int i = 0; i < widget.options.length; i++)
//						InkWell(
//							onTap: () => setState(() => model.habitMode = i),
//							child: Container(
//								padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//								color: i == model.habitMode ? Colors.green : null,
//								child: Text(
//									widget.options[i],
//									style: TextStyle(
//										color: i == model.habitMode ? Colors.black : Colors.white,
//										),
//									),
//								),
//							)
//				],
//				),
//			);
//	}
//}

class _ProviderModel with ChangeNotifier {
  int _habitMode;
  final Habit editedHabit;

  _ProviderModel(this._habitMode, {this.editedHabit}) {
    if (editedHabit != null) {
      habitMode = editedHabit.mode;
    }
  }

  int get habitMode => _habitMode;

  set habitMode(int value) {
    _habitMode = value;
    notifyListeners();
  }
}
