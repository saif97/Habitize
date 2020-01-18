import 'package:flutter/material.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_card.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/shared/text_styles.dart';
import 'package:provider/provider.dart';

import '../screen_habit_creator.dart';
import 'bottom_time_line.dart';
import 'habit_card.dart';

class HomeWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: locator<ModelHabitList>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF393e46),
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
    final ModelHabitList model = Provider.of(context);
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
    final ModelHabitList model = locator<ModelHabitList>();
    return CustomScrollView(
      slivers: <Widget>[
        HabitStream(model
            .getListHabits(habitMode: [HabitMode.Majror], showChecked: false)),
        Saperator(color: Colors.red),
        Saperator(color: Colors.amber),
        HabitStream(model
            .getListHabits(habitMode: [HabitMode.Bonus], showChecked: false)),
        Saperator(color: Colors.green),
        HabitStream(model.getListHabits(
            habitMode: HabitMode.values, showChecked: true)),
      ],
    );
  }
}

class HabitStream extends StatelessWidget {
  final List<Habit> listHabits;

  const HabitStream(this.listHabits);

  @override
  Widget build(BuildContext context) {
    ModelHabitList modelHabitList = Provider.of(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        ListView.builder(
            shrinkWrap: true,
            itemCount: listHabits.length,
            itemBuilder: (context, index) {
              final Habit habit = listHabits[index];
              return ProxyProvider0(
                  update: (_, __) =>
                      ModelHabitCard(habit, modelHabitList.selectedDate),
                  child: HabitCard(habit));
            })
      ]),
    );
  }
}

class Saperator extends StatelessWidget {
  final MaterialColor color;

  const Saperator({this.color});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          elevation: 10,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
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
