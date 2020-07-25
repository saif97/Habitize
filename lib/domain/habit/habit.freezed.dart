// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'habit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$HabitTearOff {
  const _$HabitTearOff();

  _Habit call(
      {@required UniqueId id,
      @required Name name,
      @required HabitMode mode,
      @required Goal goal,
      Map<int, int> dates,
      HabitImage image,
      HabitInfo info}) {
    return _Habit(
      id: id,
      name: name,
      mode: mode,
      goal: goal,
      dates: dates,
      image: image,
      info: info,
    );
  }
}

// ignore: unused_element
const $Habit = _$HabitTearOff();

mixin _$Habit {
  UniqueId get id;
  Name get name;
  HabitMode get mode;
  Goal get goal;
  Map<int, int> get dates;
  HabitImage get image;
  HabitInfo get info;

  $HabitCopyWith<Habit> get copyWith;
}

abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res>;
  $Res call(
      {UniqueId id,
      Name name,
      HabitMode mode,
      Goal goal,
      Map<int, int> dates,
      HabitImage image,
      HabitInfo info});

  $GoalCopyWith<$Res> get goal;
  $HabitImageCopyWith<$Res> get image;
  $HabitInfoCopyWith<$Res> get info;
}

class _$HabitCopyWithImpl<$Res> implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  final Habit _value;
  // ignore: unused_field
  final $Res Function(Habit) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object mode = freezed,
    Object goal = freezed,
    Object dates = freezed,
    Object image = freezed,
    Object info = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as UniqueId,
      name: name == freezed ? _value.name : name as Name,
      mode: mode == freezed ? _value.mode : mode as HabitMode,
      goal: goal == freezed ? _value.goal : goal as Goal,
      dates: dates == freezed ? _value.dates : dates as Map<int, int>,
      image: image == freezed ? _value.image : image as HabitImage,
      info: info == freezed ? _value.info : info as HabitInfo,
    ));
  }

  @override
  $GoalCopyWith<$Res> get goal {
    if (_value.goal == null) {
      return null;
    }
    return $GoalCopyWith<$Res>(_value.goal, (value) {
      return _then(_value.copyWith(goal: value));
    });
  }

  @override
  $HabitImageCopyWith<$Res> get image {
    if (_value.image == null) {
      return null;
    }
    return $HabitImageCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value));
    });
  }

  @override
  $HabitInfoCopyWith<$Res> get info {
    if (_value.info == null) {
      return null;
    }
    return $HabitInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

abstract class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) then) =
      __$HabitCopyWithImpl<$Res>;
  @override
  $Res call(
      {UniqueId id,
      Name name,
      HabitMode mode,
      Goal goal,
      Map<int, int> dates,
      HabitImage image,
      HabitInfo info});

  @override
  $GoalCopyWith<$Res> get goal;
  @override
  $HabitImageCopyWith<$Res> get image;
  @override
  $HabitInfoCopyWith<$Res> get info;
}

class __$HabitCopyWithImpl<$Res> extends _$HabitCopyWithImpl<$Res>
    implements _$HabitCopyWith<$Res> {
  __$HabitCopyWithImpl(_Habit _value, $Res Function(_Habit) _then)
      : super(_value, (v) => _then(v as _Habit));

  @override
  _Habit get _value => super._value as _Habit;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object mode = freezed,
    Object goal = freezed,
    Object dates = freezed,
    Object image = freezed,
    Object info = freezed,
  }) {
    return _then(_Habit(
      id: id == freezed ? _value.id : id as UniqueId,
      name: name == freezed ? _value.name : name as Name,
      mode: mode == freezed ? _value.mode : mode as HabitMode,
      goal: goal == freezed ? _value.goal : goal as Goal,
      dates: dates == freezed ? _value.dates : dates as Map<int, int>,
      image: image == freezed ? _value.image : image as HabitImage,
      info: info == freezed ? _value.info : info as HabitInfo,
    ));
  }
}

class _$_Habit implements _Habit {
  _$_Habit(
      {@required this.id,
      @required this.name,
      @required this.mode,
      @required this.goal,
      this.dates,
      this.image,
      this.info})
      : assert(id != null),
        assert(name != null),
        assert(mode != null),
        assert(goal != null);

  @override
  final UniqueId id;
  @override
  final Name name;
  @override
  final HabitMode mode;
  @override
  final Goal goal;
  @override
  final Map<int, int> dates;
  @override
  final HabitImage image;
  @override
  final HabitInfo info;

  @override
  String toString() {
    return 'Habit(id: $id, name: $name, mode: $mode, goal: $goal, dates: $dates, image: $image, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Habit &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mode, mode) ||
                const DeepCollectionEquality().equals(other.mode, mode)) &&
            (identical(other.goal, goal) ||
                const DeepCollectionEquality().equals(other.goal, goal)) &&
            (identical(other.dates, dates) ||
                const DeepCollectionEquality().equals(other.dates, dates)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mode) ^
      const DeepCollectionEquality().hash(goal) ^
      const DeepCollectionEquality().hash(dates) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(info);

  @override
  _$HabitCopyWith<_Habit> get copyWith =>
      __$HabitCopyWithImpl<_Habit>(this, _$identity);
}

abstract class _Habit implements Habit {
  factory _Habit(
      {@required UniqueId id,
      @required Name name,
      @required HabitMode mode,
      @required Goal goal,
      Map<int, int> dates,
      HabitImage image,
      HabitInfo info}) = _$_Habit;

  @override
  UniqueId get id;
  @override
  Name get name;
  @override
  HabitMode get mode;
  @override
  Goal get goal;
  @override
  Map<int, int> get dates;
  @override
  HabitImage get image;
  @override
  HabitInfo get info;
  @override
  _$HabitCopyWith<_Habit> get copyWith;
}

class _$GoalTearOff {
  const _$GoalTearOff();

  _Goal call({@required int base, @required int extended}) {
    return _Goal(
      base: base,
      extended: extended,
    );
  }
}

// ignore: unused_element
const $Goal = _$GoalTearOff();

mixin _$Goal {
  int get base;
  int get extended;

  $GoalCopyWith<Goal> get copyWith;
}

abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res>;
  $Res call({int base, int extended});
}

class _$GoalCopyWithImpl<$Res> implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  final Goal _value;
  // ignore: unused_field
  final $Res Function(Goal) _then;

  @override
  $Res call({
    Object base = freezed,
    Object extended = freezed,
  }) {
    return _then(_value.copyWith(
      base: base == freezed ? _value.base : base as int,
      extended: extended == freezed ? _value.extended : extended as int,
    ));
  }
}

abstract class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) then) =
      __$GoalCopyWithImpl<$Res>;
  @override
  $Res call({int base, int extended});
}

class __$GoalCopyWithImpl<$Res> extends _$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(_Goal _value, $Res Function(_Goal) _then)
      : super(_value, (v) => _then(v as _Goal));

  @override
  _Goal get _value => super._value as _Goal;

  @override
  $Res call({
    Object base = freezed,
    Object extended = freezed,
  }) {
    return _then(_Goal(
      base: base == freezed ? _value.base : base as int,
      extended: extended == freezed ? _value.extended : extended as int,
    ));
  }
}

class _$_Goal implements _Goal {
  _$_Goal({@required this.base, @required this.extended})
      : assert(base != null),
        assert(extended != null);

  @override
  final int base;
  @override
  final int extended;

  @override
  String toString() {
    return 'Goal(base: $base, extended: $extended)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Goal &&
            (identical(other.base, base) ||
                const DeepCollectionEquality().equals(other.base, base)) &&
            (identical(other.extended, extended) ||
                const DeepCollectionEquality()
                    .equals(other.extended, extended)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(base) ^
      const DeepCollectionEquality().hash(extended);

  @override
  _$GoalCopyWith<_Goal> get copyWith =>
      __$GoalCopyWithImpl<_Goal>(this, _$identity);
}

abstract class _Goal implements Goal {
  factory _Goal({@required int base, @required int extended}) = _$_Goal;

  @override
  int get base;
  @override
  int get extended;
  @override
  _$GoalCopyWith<_Goal> get copyWith;
}

class _$HabitImageTearOff {
  const _$HabitImageTearOff();

  _HabitImage call({@required Url imgUrl, @required double imgY_Alignment}) {
    return _HabitImage(
      imgUrl: imgUrl,
      imgY_Alignment: imgY_Alignment,
    );
  }
}

// ignore: unused_element
const $HabitImage = _$HabitImageTearOff();

mixin _$HabitImage {
  Url get imgUrl;
  double get imgY_Alignment;

  $HabitImageCopyWith<HabitImage> get copyWith;
}

abstract class $HabitImageCopyWith<$Res> {
  factory $HabitImageCopyWith(
          HabitImage value, $Res Function(HabitImage) then) =
      _$HabitImageCopyWithImpl<$Res>;
  $Res call({Url imgUrl, double imgY_Alignment});
}

class _$HabitImageCopyWithImpl<$Res> implements $HabitImageCopyWith<$Res> {
  _$HabitImageCopyWithImpl(this._value, this._then);

  final HabitImage _value;
  // ignore: unused_field
  final $Res Function(HabitImage) _then;

  @override
  $Res call({
    Object imgUrl = freezed,
    Object imgY_Alignment = freezed,
  }) {
    return _then(_value.copyWith(
      imgUrl: imgUrl == freezed ? _value.imgUrl : imgUrl as Url,
      imgY_Alignment: imgY_Alignment == freezed
          ? _value.imgY_Alignment
          : imgY_Alignment as double,
    ));
  }
}

abstract class _$HabitImageCopyWith<$Res> implements $HabitImageCopyWith<$Res> {
  factory _$HabitImageCopyWith(
          _HabitImage value, $Res Function(_HabitImage) then) =
      __$HabitImageCopyWithImpl<$Res>;
  @override
  $Res call({Url imgUrl, double imgY_Alignment});
}

class __$HabitImageCopyWithImpl<$Res> extends _$HabitImageCopyWithImpl<$Res>
    implements _$HabitImageCopyWith<$Res> {
  __$HabitImageCopyWithImpl(
      _HabitImage _value, $Res Function(_HabitImage) _then)
      : super(_value, (v) => _then(v as _HabitImage));

  @override
  _HabitImage get _value => super._value as _HabitImage;

  @override
  $Res call({
    Object imgUrl = freezed,
    Object imgY_Alignment = freezed,
  }) {
    return _then(_HabitImage(
      imgUrl: imgUrl == freezed ? _value.imgUrl : imgUrl as Url,
      imgY_Alignment: imgY_Alignment == freezed
          ? _value.imgY_Alignment
          : imgY_Alignment as double,
    ));
  }
}

class _$_HabitImage implements _HabitImage {
  _$_HabitImage({@required this.imgUrl, @required this.imgY_Alignment})
      : assert(imgUrl != null),
        assert(imgY_Alignment != null);

  @override
  final Url imgUrl;
  @override
  final double imgY_Alignment;

  @override
  String toString() {
    return 'HabitImage(imgUrl: $imgUrl, imgY_Alignment: $imgY_Alignment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitImage &&
            (identical(other.imgUrl, imgUrl) ||
                const DeepCollectionEquality().equals(other.imgUrl, imgUrl)) &&
            (identical(other.imgY_Alignment, imgY_Alignment) ||
                const DeepCollectionEquality()
                    .equals(other.imgY_Alignment, imgY_Alignment)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(imgUrl) ^
      const DeepCollectionEquality().hash(imgY_Alignment);

  @override
  _$HabitImageCopyWith<_HabitImage> get copyWith =>
      __$HabitImageCopyWithImpl<_HabitImage>(this, _$identity);
}

abstract class _HabitImage implements HabitImage {
  factory _HabitImage({@required Url imgUrl, @required double imgY_Alignment}) =
      _$_HabitImage;

  @override
  Url get imgUrl;
  @override
  double get imgY_Alignment;
  @override
  _$HabitImageCopyWith<_HabitImage> get copyWith;
}

class _$HabitInfoTearOff {
  const _$HabitInfoTearOff();

  _HabitInfo call({String when, String reward}) {
    return _HabitInfo(
      when: when,
      reward: reward,
    );
  }
}

// ignore: unused_element
const $HabitInfo = _$HabitInfoTearOff();

mixin _$HabitInfo {
  String get when;
  String get reward;

  $HabitInfoCopyWith<HabitInfo> get copyWith;
}

abstract class $HabitInfoCopyWith<$Res> {
  factory $HabitInfoCopyWith(HabitInfo value, $Res Function(HabitInfo) then) =
      _$HabitInfoCopyWithImpl<$Res>;
  $Res call({String when, String reward});
}

class _$HabitInfoCopyWithImpl<$Res> implements $HabitInfoCopyWith<$Res> {
  _$HabitInfoCopyWithImpl(this._value, this._then);

  final HabitInfo _value;
  // ignore: unused_field
  final $Res Function(HabitInfo) _then;

  @override
  $Res call({
    Object when = freezed,
    Object reward = freezed,
  }) {
    return _then(_value.copyWith(
      when: when == freezed ? _value.when : when as String,
      reward: reward == freezed ? _value.reward : reward as String,
    ));
  }
}

abstract class _$HabitInfoCopyWith<$Res> implements $HabitInfoCopyWith<$Res> {
  factory _$HabitInfoCopyWith(
          _HabitInfo value, $Res Function(_HabitInfo) then) =
      __$HabitInfoCopyWithImpl<$Res>;
  @override
  $Res call({String when, String reward});
}

class __$HabitInfoCopyWithImpl<$Res> extends _$HabitInfoCopyWithImpl<$Res>
    implements _$HabitInfoCopyWith<$Res> {
  __$HabitInfoCopyWithImpl(_HabitInfo _value, $Res Function(_HabitInfo) _then)
      : super(_value, (v) => _then(v as _HabitInfo));

  @override
  _HabitInfo get _value => super._value as _HabitInfo;

  @override
  $Res call({
    Object when = freezed,
    Object reward = freezed,
  }) {
    return _then(_HabitInfo(
      when: when == freezed ? _value.when : when as String,
      reward: reward == freezed ? _value.reward : reward as String,
    ));
  }
}

class _$_HabitInfo implements _HabitInfo {
  _$_HabitInfo({this.when, this.reward});

  @override
  final String when;
  @override
  final String reward;

  @override
  String toString() {
    return 'HabitInfo(when: $when, reward: $reward)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitInfo &&
            (identical(other.when, when) ||
                const DeepCollectionEquality().equals(other.when, when)) &&
            (identical(other.reward, reward) ||
                const DeepCollectionEquality().equals(other.reward, reward)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(when) ^
      const DeepCollectionEquality().hash(reward);

  @override
  _$HabitInfoCopyWith<_HabitInfo> get copyWith =>
      __$HabitInfoCopyWithImpl<_HabitInfo>(this, _$identity);
}

abstract class _HabitInfo implements HabitInfo {
  factory _HabitInfo({String when, String reward}) = _$_HabitInfo;

  @override
  String get when;
  @override
  String get reward;
  @override
  _$HabitInfoCopyWith<_HabitInfo> get copyWith;
}
