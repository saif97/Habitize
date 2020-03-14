import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
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
          icon: Icon(Icons.edit, size: 30),
          onPressed: () async => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ScreenCreateHabit())),
        )
      ],
    );
  }
}

class SliverScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        HabitStream(habitMode: [HabitMode.Majror], showChecked: false),
        Saperator(color: Colors.red),
        Saperator(color: Colors.amber),
        HabitStream(habitMode: [HabitMode.Bonus], showChecked: false),
        Saperator(color: Colors.green),
        HabitStream(habitMode: HabitMode.values, showChecked: true),
      ],
    );
  }
}

class HabitStream extends StatelessWidget {
  final List<HabitMode> habitMode;
  final bool showChecked;

  HabitStream({@required this.habitMode, @required this.showChecked});

  @override
  Widget build(BuildContext context) {
    final ModelHabitList _modelHabitList = Provider.of(context);

    final List<Habit> filteredHabits = _modelHabitList.filterHabits(
        showChecked: showChecked, habitMode: habitMode);
    return SliverList(
      delegate: SliverChildListDelegate([
        AnimatedList(
          shrinkWrap: true,
          initialItemCount: filteredHabits.length,
          itemBuilder: (context, index, a) {
            final Habit habit = filteredHabits[index];
            return ProxyProvider0(
              update: (_, __) =>
                  ModelHabitCard(habit, _modelHabitList.selectedDate),
              child: HabitCard(habit),
            );
          },
        )
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
