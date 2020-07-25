import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../infrastructure/habit/Habit.dart';
import '../../application/view_models/model_habit_card.dart';
import '../../domain/shared/constants.dart';
import '../../domain/shared/text_styles.dart';
import '../../domain/shared/widgets.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard(this.habit);

  // TODO: The swiping bit that comes when you swipe is odd.
  // TODO: apply one single rounded clip to the whole widget.
  @override
  Widget build(BuildContext context) {
    const double cardRadius = 15;
    final ModelHabitCard model = Provider.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRadius)),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => model.openHabitInfo(context),
        child: Container(
          height: habit.imgUrl == null ? 85 : (85 + UNSPLASH_IMAGE_HEIGHT),
          child: Column(
            children: <Widget>[
              if (habit.imgUrl != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(cardRadius),
                    topRight: Radius.circular(cardRadius),
                  ),
                  child: CCachedNetworkImage(url: habit.imgUrl, yAligment: habit.imgY_Alignment),
                ),
              CustomSlidable(
                habit: habit,
                child: ListTile(
                  key: Key(habit.key.toString()),
                  title: Text(
                    habit.name,
                    style: model.isHabitChecked ? CTextStyle.checkHabits : null,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (habit.when != null) Text("When: ${habit.when}"),
                        if (habit.reward != null) Text("Reward: ${habit.reward ?? ""}"),
                      ],
                    ),
                  ),
                  leading: Text(model.habitStreak),
                  trailing: model.getIterationText(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSlidable extends StatelessWidget {
  ModelHabitCard model;
  @required
  final Habit habit;
  @required
  final Widget child;

  CustomSlidable({this.habit, this.child});

  @override
  Widget build(BuildContext context) {
    final SlidableController slidableController = SlidableController();
    model = Provider.of(context);

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
          color: Colors.lightGreen,
          onTap: () => model.slidableCheckHabit(checkAll: false),
        ),
        if (habit.goal > 1)
          IconSlideAction(
            caption: "Check All",
            icon: model.isHabitChecked ? Icons.done_outline : Icons.done_all,
            color: model.isHabitChecked ? Colors.amber : Colors.green,
            onTap: () => model.slidableCheckHabit(checkAll: true),
          )
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Delete",
          icon: Icons.delete,
          color: Colors.redAccent,
          onTap: () {
            createDeletionAlertDialog(context);
          },
        ),
        IconSlideAction(
          caption: "Edit",
          icon: Icons.edit,
          onTap: () => model.OpenHabitEditor(context),
          color: Colors.orangeAccent,
        ),
      ],
      child: child,
    );
  }

  void createDeletionAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Habit?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                await model.deleteHabit();
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
