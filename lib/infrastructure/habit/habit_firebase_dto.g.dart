// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_firebase_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HabitFirebaseDto _$_$_HabitFirebaseDtoFromJson(Map<String, dynamic> json) {
  return _$_HabitFirebaseDto(
    id: json['id'] as String,
    name: json['name'] as String,
    mode: json['mode'] as String,
    goalBase: json['goalBase'] as int,
    goalExtended: json['goalExtended'] as int,
    dates: (json['dates'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
    when: json['when'] as String,
    reward: json['reward'] as String,
    imageUrl: json['imageUrl'] as String,
    imgY_Alignment: (json['imgY_Alignment'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_HabitFirebaseDtoToJson(
        _$_HabitFirebaseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mode': instance.mode,
      'goalBase': instance.goalBase,
      'goalExtended': instance.goalExtended,
      'dates': instance.dates?.map((k, e) => MapEntry(k.toString(), e)),
      'when': instance.when,
      'reward': instance.reward,
      'imageUrl': instance.imageUrl,
      'imgY_Alignment': instance.imgY_Alignment,
    };
