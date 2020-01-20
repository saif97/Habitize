import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_card.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/shared/text_styles.dart';
import 'package:provider/provider.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard(this.habit);

  @override
  Widget build(BuildContext context) {
    final ModelHabitCard model = Provider.of(context);
    return CustomSlidable(
      habit: habit,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => model.openHabitInfo(context),
        child: ListTile(
          key: Key(habit.id.toString()),
          title: Text(
            habit.name ?? "error no name",
            style: model.isHabitChecked ? CTextStyle.checkHabits : null,
          ),
          subtitle: Text(model.habitStreak),
          leading: model.isHabitChecked
              ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(Icons.home),
          trailing: habit.goal > 1 ? Text(model.currentIteration) : null,
        ),
      ),
    );
  }
}

class CustomSlidable extends StatelessWidget {
  @required
  final Habit habit;
  @required
  final Widget child;

  const CustomSlidable({this.habit, this.child});

  @override
  Widget build(BuildContext context) {
    final SlidableController slidableController = SlidableController();
    final ModelHabitCard model = Provider.of(context);

    return Slidable(
      controller: slidableController,
      key: model.key,
      actionPane: const SlidableDrawerActionPane(),
      dismissal: SlidableDismissal(
        dismissThresholds: const <SlideActionType, double>{
          SlideActionType.primary: 0,
          SlideActionType.secondary: 1
        },
        onWillDismiss: (actionType) => model.slidableOnWillDismiss(actionType),
        child: const SlidableDrawerDismissal(),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: model.getSwipeRightText(),
          icon: Icons.done,
          color: model.isHabitChecked ? Colors.amberAccent : Colors.lightGreen,
          onTap: () => model.slidableCheckHabit(checkOnce: true),
        ),
        if (habit.goal > 1)
          IconSlideAction(
            caption: "Check All",
            icon: model.isHabitChecked ? Icons.done_outline : Icons.done_all,
            color: model.isHabitChecked ? Colors.amber : Colors.green,
            onTap: () => model.slidableCheckHabit(checkOnce: false),
          )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Delete",
          icon: Icons.delete,
          color: Colors.redAccent,
          onTap: () {
            createAlertDialog(context);
          },
        ),
        IconSlideAction(
          caption: "Edit",
          icon: Icons.edit,
          color: Colors.orangeAccent,
          onTap: () {
//						Navigator.push(
//								context,
//								MaterialPageRoute(
//										builder: (context) => ScreenCreateHabit(
//											editedHabit: habit,
//											)));
//						ScreenCreateHabit(
//							editedHabit: habit,
//							);
          },
        ),
      ],
      child: child,
    );
  }

  void createAlertDialog(BuildContext context) {
    final DB_API _dp_api = locator<DB_API>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Habit?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                await _dp_api.deleteHabit(habit.id);
                await locator<ModelHabitList>().initModel();
                Navigator.pop(context);
              },
              child: const Text('Accept'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
