import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';

// flutterS pub run build_runner build --delete-conflicting-outputs
@freezed
abstract class Habit with _$Habit {
  factory Habit() = _Habit;
}
