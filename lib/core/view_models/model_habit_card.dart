import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitize3/core/models/habit.dart';
import 'package:habitize3/core/serivces/db_api/db_api.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/utils/locator.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';
import 'package:habitize3/ui/screens/habit_info/screen_habit_info.dart';

class ModelHabitCard {
	final DB_API _db_api = locator<DB_API>();

	ModelHabitList modelHabitList = locator<ModelHabitList>();
	bool _isHabitChecked;
	String _currentIteration;
	String _habitStreak;
	Key _key;
	final Habit habit;
	final DateTime selectedDate;

	void initModel() {
		print("=========Card initialized=========");
		_isHabitChecked = _db_api.isHabitChecked(habit: habit, date: selectedDate);

		_currentIteration = (habit.dates[selectedDate.millisecondsSinceEpoch] ??=
				habit.goal)
				.toString();
		_habitStreak = _getHabitStreak();

		_key = Key(
				"${habit.id}-${habit.dates[selectedDate.millisecondsSinceEpoch] ??
											 -2}");
	}

	Future openHabitInfo(BuildContext context) async {
		final bool r = await Navigator.push(context,
																						MaterialPageRoute(
																								builder: (context) =>
																										ScreenHabitInfo(habit)));
		if (r ?? false) {
			await modelHabitList.initModel();
		}
	}

	String _getHabitStreak() {
		// get how many days the habit is checked in a row by, getting the last day
		// the habit was checked & compare it to today or yesterday.
		int streak = 1;

		final Map<int, int> dates = habit.dates;
		final List<int> ordredDateKeys = dates.keys.toList()
			..sort();

		// is the habit checked before.
		final int todayInMilSecs = getTodayDateInt();

		final int yesterdayInMilSecs =
		getTodayDateInt(addDuration: const Duration(days: -1));

		final bool bool1 =
				dates.containsKey(todayInMilSecs) && dates[todayInMilSecs] <= 0;

		final bool bool2 =
				dates.containsKey(yesterdayInMilSecs) && dates[yesterdayInMilSecs] <= 0;

		if (bool1 || bool2) {
			habit.printData(detailedDatesInfo: true);
			// iterate over all the dates in the map and check if they're in row.
			for (var i = ordredDateKeys.length - 2; i > 0; --i) {
				final DateTime date1 =
				DateTime.fromMillisecondsSinceEpoch(ordredDateKeys.elementAt(i));

				if (!_db_api.isHabitChecked(habit: habit, date: date1)) break;

				final date2 = DateTime.fromMillisecondsSinceEpoch(
						ordredDateKeys.elementAt(i - 1));

				if (!_db_api.isHabitChecked(habit: habit, date: date2)) break;

				if (date1.difference(date2) == const Duration(days: 1))
					streak++;
				else
					break;
			}
		}

		if (streak == 1)
			return 'Check today to have your first streak';
		else {
			if (streak < 21)
				return '${streak.toString()} => 21';
			else if (streak < 43)
				return '${streak.toString()} => 43';
			else if (streak < 66) return '${streak.toString()} => 66';
			return streak.toString();
		}
	}

	String getSwipeRightText() {
		String swipeRightText;
		if (habit.goal > 1)
			swipeRightText = 'Done Once';
		else if (_isHabitChecked)
			swipeRightText = "Undo";
		else
			swipeRightText = "Done";
		return swipeRightText;
	}

	bool slidableOnWillDismiss(SlideActionType actionType) {
		if (actionType == SlideActionType.primary) {
			// check if habit is checked for today.
			slidableCheckHabit(checkOnce: true);
			return true;
		}
		return false;
	}

	Future slidableCheckHabit({@required bool checkOnce}) async {
		await _db_api.checkHabitDone(habit.id, selectedDate,
																		 checkAll: checkOnce ? null :
																							 !isHabitChecked);

		await modelHabitList.initModel();
	}

	//=============> GETTERS & SETTERS <==============\\

	ModelHabitCard(this.habit, this.selectedDate) {
		initModel();
	}

	String get currentIteration => _currentIteration;

	bool get isHabitChecked => _isHabitChecked;

	String get habitStreak => _habitStreak;

	Key get key => _key;
}
