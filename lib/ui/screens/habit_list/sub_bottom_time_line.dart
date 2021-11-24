import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/view_models/model_habit_list.dart';

class BottomTimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ModelHabitList model = Provider.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 60,
        color: Colors.black45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: model.bottomBarElements,
        ),
      ),
    );
  }
}

class TimeLineCircle extends StatelessWidget {
  final DateTime day;
  final bool isAllChecked;

  const TimeLineCircle(this.day, {required this.isAllChecked});

  @override
  Widget build(BuildContext context) {
    final ModelHabitList model = Provider.of(context);
    return InkWell(
      onTap: () => model.selectedDate = day,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              blurRadius: 20,
              spreadRadius: -10,
            )
          ],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.green,
          radius: model.selectedDate == day ? 25 : 20,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: isAllChecked ? Colors.green : null,
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
