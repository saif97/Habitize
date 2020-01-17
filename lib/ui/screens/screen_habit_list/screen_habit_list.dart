import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/shared/text_styles.dart';
import 'package:provider/provider.dart';

import '../screen_habit_creator.dart';
import 'bottom_time_line.dart';
import 'habit_list.dart';

class HomeWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: locator<ModelHabitList>(),
      child: Scaffold(
        backgroundColor: Color(0xFF393e46),
        body: SafeArea(
          child: Consumer<ModelHabitList>(
            builder: (_, model, __) {
              return Column(
                children: <Widget>[
                  CAppbar(),
                  Expanded(child: SliverScrollView()),
                  BottomTimeLine(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModelHabitList model = Provider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.getTitle(), style: CTextStyle.title),
        ),
        IconButton(
          icon: Icon(
            Icons.edit,
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScreenCreateHabit()));
          },
        )
      ],
    );
  }
}

class SliverScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModelHabitList model = locator();

    return CustomScrollView(
      slivers: <Widget>[
        HabitStream(model.getListHabits([HabitMode.Majror], false)),
        Saperator(color: Colors.red),
        Saperator(color: Colors.amber),
        HabitStream(model.getListHabits([HabitMode.Bonus], false)),
        Saperator(color: Colors.green),
        HabitStream(model.getListHabits(HabitMode.values, true)),
      ],
    );
  }
}

class Saperator extends StatelessWidget {
  MaterialColor color;

  Saperator({this.color});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          elevation: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Container(
              width: double.infinity,
              height: 5,
              color: color,
            ),
          ),
        )
      ]),
    );
  }
}
