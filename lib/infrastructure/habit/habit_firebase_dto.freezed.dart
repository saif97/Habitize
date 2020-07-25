// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'habit_firebase_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
HabitFirebaseDto _$HabitFirebaseDtoFromJson(Map<String, dynamic> json) {
  return _HabitFirebaseDto.fromJson(json);
}

class _$HabitFirebaseDtoTearOff {
  const _$HabitFirebaseDtoTearOff();

  _HabitFirebaseDto call(
      {@required String id,
      @required String name,
      @required String mode,
      @required int goalBase,
      int goalExtended,
      Map<int, int> dates,
      String when,
      String reward,
      String imageUrl,
      double imgY_Alignment}) {
    return _HabitFirebaseDto(
      id: id,
      name: name,
      mode: mode,
      goalBase: goalBase,
      goalExtended: goalExtended,
      dates: dates,
      when: when,
      reward: reward,
      imageUrl: imageUrl,
      imgY_Alignment: imgY_Alignment,
    );
  }
}

// ignore: unused_element
const $HabitFirebaseDto = _$HabitFirebaseDtoTearOff();

mixin _$HabitFirebaseDto {
  String get id;
  String get name;
  String get mode;
  int get goalBase;
  int get goalExtended;
  Map<int, int> get dates;
  String get when;
  String get reward;
  String get imageUrl;
  double get imgY_Alignment;

  Map<String, dynamic> toJson();
  $HabitFirebaseDtoCopyWith<HabitFirebaseDto> get copyWith;
}

abstract class $HabitFirebaseDtoCopyWith<$Res> {
  factory $HabitFirebaseDtoCopyWith(
          HabitFirebaseDto value, $Res Function(HabitFirebaseDto) then) =
      _$HabitFirebaseDtoCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String mode,
      int goalBase,
      int goalExtended,
      Map<int, int> dates,
      String when,
      String reward,
      String imageUrl,
      double imgY_Alignment});
}

class _$HabitFirebaseDtoCopyWithImpl<$Res>
    implements $HabitFirebaseDtoCopyWith<$Res> {
  _$HabitFirebaseDtoCopyWithImpl(this._value, this._then);

  final HabitFirebaseDto _value;
  // ignore: unused_field
  final $Res Function(HabitFirebaseDto) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object mode = freezed,
    Object goalBase = freezed,
    Object goalExtended = freezed,
    Object dates = freezed,
    Object when = freezed,
    Object reward = freezed,
    Object imageUrl = freezed,
    Object imgY_Alignment = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      mode: mode == freezed ? _value.mode : mode as String,
      goalBase: goalBase == freezed ? _value.goalBase : goalBase as int,
      goalExtended:
          goalExtended == freezed ? _value.goalExtended : goalExtended as int,
      dates: dates == freezed ? _value.dates : dates as Map<int, int>,
      when: when == freezed ? _value.when : when as String,
      reward: reward == freezed ? _value.reward : reward as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      imgY_Alignment: imgY_Alignment == freezed
          ? _value.imgY_Alignment
          : imgY_Alignment as double,
    ));
  }
}

abstract class _$HabitFirebaseDtoCopyWith<$Res>
    implements $HabitFirebaseDtoCopyWith<$Res> {
  factory _$HabitFirebaseDtoCopyWith(
          _HabitFirebaseDto value, $Res Function(_HabitFirebaseDto) then) =
      __$HabitFirebaseDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String mode,
      int goalBase,
      int goalExtended,
      Map<int, int> dates,
      String when,
      String reward,
      String imageUrl,
      double imgY_Alignment});
}

class __$HabitFirebaseDtoCopyWithImpl<$Res>
    extends _$HabitFirebaseDtoCopyWithImpl<$Res>
    implements _$HabitFirebaseDtoCopyWith<$Res> {
  __$HabitFirebaseDtoCopyWithImpl(
      _HabitFirebaseDto _value, $Res Function(_HabitFirebaseDto) _then)
      : super(_value, (v) => _then(v as _HabitFirebaseDto));

  @override
  _HabitFirebaseDto get _value => super._value as _HabitFirebaseDto;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object mode = freezed,
    Object goalBase = freezed,
    Object goalExtended = freezed,
    Object dates = freezed,
    Object when = freezed,
    Object reward = freezed,
    Object imageUrl = freezed,
    Object imgY_Alignment = freezed,
  }) {
    return _then(_HabitFirebaseDto(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      mode: mode == freezed ? _value.mode : mode as String,
      goalBase: goalBase == freezed ? _value.goalBase : goalBase as int,
      goalExtended:
          goalExtended == freezed ? _value.goalExtended : goalExtended as int,
      dates: dates == freezed ? _value.dates : dates as Map<int, int>,
      when: when == freezed ? _value.when : when as String,
      reward: reward == freezed ? _value.reward : reward as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      imgY_Alignment: imgY_Alignment == freezed
          ? _value.imgY_Alignment
          : imgY_Alignment as double,
    ));
  }
}

@JsonSerializable()
class _$_HabitFirebaseDto extends _HabitFirebaseDto {
  _$_HabitFirebaseDto(
      {@required this.id,
      @required this.name,
      @required this.mode,
      @required this.goalBase,
      this.goalExtended,
      this.dates,
      this.when,
      this.reward,
      this.imageUrl,
      this.imgY_Alignment})
      : assert(id != null),
        assert(name != null),
        assert(mode != null),
        assert(goalBase != null),
        super._();

  factory _$_HabitFirebaseDto.fromJson(Map<String, dynamic> json) =>
      _$_$_HabitFirebaseDtoFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String mode;
  @override
  final int goalBase;
  @override
  final int goalExtended;
  @override
  final Map<int, int> dates;
  @override
  final String when;
  @override
  final String reward;
  @override
  final String imageUrl;
  @override
  final double imgY_Alignment;

  @override
  String toString() {
    return 'HabitFirebaseDto(id: $id, name: $name, mode: $mode, goalBase: $goalBase, goalExtended: $goalExtended, dates: $dates, when: $when, reward: $reward, imageUrl: $imageUrl, imgY_Alignment: $imgY_Alignment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitFirebaseDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mode, mode) ||
                const DeepCollectionEquality().equals(other.mode, mode)) &&
            (identical(other.goalBase, goalBase) ||
                const DeepCollectionEquality()
                    .equals(other.goalBase, goalBase)) &&
            (identical(other.goalExtended, goalExtended) ||
                const DeepCollectionEquality()
                    .equals(other.goalExtended, goalExtended)) &&
            (identical(other.dates, dates) ||
                const DeepCollectionEquality().equals(other.dates, dates)) &&
            (identical(other.when, when) ||
                const DeepCollectionEquality().equals(other.when, when)) &&
            (identical(other.reward, reward) ||
                const DeepCollectionEquality().equals(other.reward, reward)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.imgY_Alignment, imgY_Alignment) ||
                const DeepCollectionEquality()
                    .equals(other.imgY_Alignment, imgY_Alignment)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mode) ^
      const DeepCollectionEquality().hash(goalBase) ^
      const DeepCollectionEquality().hash(goalExtended) ^
      const DeepCollectionEquality().hash(dates) ^
      const DeepCollectionEquality().hash(when) ^
      const DeepCollectionEquality().hash(reward) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(imgY_Alignment);

  @override
  _$HabitFirebaseDtoCopyWith<_HabitFirebaseDto> get copyWith =>
      __$HabitFirebaseDtoCopyWithImpl<_HabitFirebaseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HabitFirebaseDtoToJson(this);
  }
}

abstract class _HabitFirebaseDto extends HabitFirebaseDto {
  _HabitFirebaseDto._() : super._();
  factory _HabitFirebaseDto(
      {@required String id,
      @required String name,
      @required String mode,
      @required int goalBase,
      int goalExtended,
      Map<int, int> dates,
      String when,
      String reward,
      String imageUrl,
      double imgY_Alignment}) = _$_HabitFirebaseDto;

  factory _HabitFirebaseDto.fromJson(Map<String, dynamic> json) =
      _$_HabitFirebaseDto.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get mode;
  @override
  int get goalBase;
  @override
  int get goalExtended;
  @override
  Map<int, int> get dates;
  @override
  String get when;
  @override
  String get reward;
  @override
  String get imageUrl;
  @override
  double get imgY_Alignment;
  @override
  _$HabitFirebaseDtoCopyWith<_HabitFirebaseDto> get copyWith;
}
