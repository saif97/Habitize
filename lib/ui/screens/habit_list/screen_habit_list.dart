import 'package:flutter/material.dart';
import 'package:habitize3/core/models/Habit.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_card.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/shared/text_styles.dart';
import 'package:provider/provider.dart';

import 'sub_bottom_time_line.dart';
import 'sub_habit_card.dart';

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
        const Spacer(),
        FlatButton(
          onPressed: () => model.showAllHabits = !model.showAllHabits,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: model.showAllHabits ? Colors.greenAccent : Colors.redAccent,
          child: Text(model.showAllHabits ? "Hide All" : "Show All"),
        ),
        IconButton(
          icon: Icon(Icons.edit, size: 30),
          onPressed: () async => model.openHabitCreator(context),
        ),
      ],
    );
  }
}

class SliverScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        HabitStream(selectedHabitMode: [HabitMode.Majror], showChecked: false),
        Saperator(color: Colors.red),
        Saperator(color: Colors.amber),
        HabitStream(selectedHabitMode: [HabitMode.Bonus], showChecked: false),
        Saperator(color: Colors.green),
        HabitStream(selectedHabitMode: HabitMode.values, showChecked: true),
      ],
    );
  }
}

class HabitStream extends StatelessWidget {
  final List<HabitMode> selectedHabitMode;
  final bool showChecked;

  HabitStream({@required this.selectedHabitMode, @required this.showChecked});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Consumer<ModelHabitList>(
          builder: (_, model, __) {
            if (model.isShowHabitFor(selectedHabitMode)) {
              final List<Habit> filteredHabits = model.filterHabits(
                  showChecked: showChecked, habitMode: selectedHabitMode);
              return ListView.builder(
                itemCount: filteredHabits.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  final Habit habit = filteredHabits[i];
                  return ProxyProvider0(
                    update: (_, __) =>
                        ModelHabitCard(habit, model.selectedDate),
                    child: HabitCard(habit),
                  );
                },
              );
            } else
              return Container();
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
