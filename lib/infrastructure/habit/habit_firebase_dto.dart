import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/core/value_objects.dart';
import '../../domain/habit/habit.dart';
import 'Habit_hive_dto.dart';

part 'habit_firebase_dto.freezed.dart';
part 'habit_firebase_dto.g.dart';

// flutterS pub run build_runner build --delete-conflicting-outputs
@freezed
abstract class HabitFirebaseDto implements _$HabitFirebaseDto {
  const HabitFirebaseDto._();
  factory HabitFirebaseDto({
    @required String id,
    @required String name,
    @required String mode,
    @required int goalBase,
    int goalExtended,
    Map<int, int> dates,
    String when,
    String reward,
    String imageUrl,
    double imgY_Alignment,
  }) = _HabitFirebaseDto;

  factory HabitFirebaseDto.fromJson(Map<String, dynamic> json) => _$HabitFirebaseDtoFromJson(json);
  factory HabitFirebaseDto.fromFirestore(DocumentSnapshot doc) =>
      HabitFirebaseDto.fromJson(doc.data).copyWith(id: doc.documentID);

  factory HabitFirebaseDto.fromDomain(Habit habit) => HabitFirebaseDto(
      id: habit.id.getOrCrash(),
      name: habit.name.getOrCrash(),
      mode: habit.mode.toString(),
      imageUrl: habit.image.imgUrl.getOrDefaultToEmptyString(),
      dates: habit.dates,
      goalBase: habit.goal.base,
      goalExtended: habit.goal.extended,
      imgY_Alignment: habit.image.imgY_Alignment,
      reward: habit.info.reward,
      when: habit.info.when);

  Habit toDomain() => Habit(
        id: UniqueId(id),
        name: Name(name),
        dates: dates,
        goal: Goal(base: goalBase, extended: goalExtended),
        mode: EnumToString.fromString(HabitMode.values, mode),
        image: HabitImage(imgUrl: Url(imageUrl), imgY_Alignment: imgY_Alignment),
        info: HabitInfo(reward: reward, when: when),
      );
}
