import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructure/habit/Habit_hive_dto.dart';
import '../core/value_objects.dart';

part 'habit.freezed.dart';

// flutterS pub run build_runner build --delete-conflicting-outputs
@freezed
abstract class Habit with _$Habit {
  factory Habit({
    @required UniqueId id,
    @required Name name,
    @required HabitMode mode,
    @required Goal goal,
    Map<int, int> dates,
    HabitImage image,
    HabitInfo info,
  }) = _Habit;
}

@freezed
abstract class Goal with _$Goal {
  factory Goal({
    @required int base,
    @required int extended,
  }) = _Goal;
}

@freezed
abstract class HabitImage with _$HabitImage {
  factory HabitImage({
    @required Url imgUrl,
    @required double imgY_Alignment,
  }) = _HabitImage;
}

@freezed
abstract class HabitInfo with _$HabitInfo {
  factory HabitInfo({
    String when,
    String reward,
  }) = _HabitInfo;
}
