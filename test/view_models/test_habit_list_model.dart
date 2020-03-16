import 'package:flutter_test/flutter_test.dart';
import 'package:habitize3/core/utils/functions.dart';
import 'package:habitize3/core/view_models/model_habit_list.dart';

void testTitle() {
  test("Test Home screen title, which changes depending on the selected date",
      () {
    final ModelHabitList model = ModelHabitList();

    model.selectedDate = getTodayDate();
    String title;
    title = model.getTitle();
    expect(title, 'Today');

    model.selectedDate = getTodayDate().add(const Duration(days: -1));
    title = model.getTitle();
    expect(title, 'Yesterday');

    model.selectedDate = getTodayDate().add(const Duration(days: -5));
    title = model.getTitle();
    expect(title, '5 Days ago');

    // here my code supposed to th
    expect(
      () {
        model.selectedDate = getTodayDate().add(const Duration(days: 5));
      },
      AssertionError,
    );
  });
}
