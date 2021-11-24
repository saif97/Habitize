import 'package:Streak/ui/shared/shared_wids.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../core/models/Habit.dart';
import '../../../core/view_models/model_habit_card.dart';
import '../../shared/constants.dart';
import '../../shared/text_styles.dart';

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
        child: SizedBox(
          height: habit.imgUrl == null ? 85 : (85 + UNSPLASH_IMAGE_HEIGHT),
          child: Column(
            children: <Widget>[
              if (habit.imgUrl != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(cardRadius),
                    topRight: Radius.circular(cardRadius),
                  ),
                  child: SharedCachedNetworkImage(url: habit.imgUrl!, yAlignment: habit.imgY_Alignment),
                ),
              CustomSlidable(
                habit: habit,
                child: ListTile(
                  key: Key(habit.key),
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
  final Habit habit;

  final Widget child;

  CustomSlidable({required this.habit, required this.child});

  @override
  Widget build(BuildContext context) {
    final ModelHabitCard model = Provider.of(context);

    return Slidable(
      key: model.key,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: model.getSwipeRightText(),
            icon: Icons.done,
            backgroundColor: Colors.lightGreen,
            onPressed: (_) => model.slidableCheckHabit(checkAll: false),
          ),
          if (habit.goal > 1)
            SlidableAction(
              label: "Check All",
              icon: model.isHabitChecked ? Icons.done_outline : Icons.done_all,
              backgroundColor: model.isHabitChecked ? Colors.amber : Colors.green,
              onPressed: (_) => model.slidableCheckHabit(checkAll: true),
            )
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: "Delete",
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
            onPressed: (_) => createDeletionAlertDialog(context),
          ),
          SlidableAction(
            label: "Edit",
            icon: Icons.edit,
            onPressed: (_) => model.OpenHabitEditor(context),
            backgroundColor: Colors.orangeAccent,
          ),
        ],
      ),
      child: child,
    );
  }

  void createDeletionAlertDialog(BuildContext context) {
    final ModelHabitCard model = Provider.of(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Habit?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await model.deleteHabit();
                Navigator.pop(context);
              },
              child: const Text('Accept'),
            ),
            ElevatedButton(
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
