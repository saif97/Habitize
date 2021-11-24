// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 1;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      dates: (fields[4] as Map).cast<int, int>(),
      name: fields[1] as String,
      goal: fields[3] as int,
      mode: fields[2] as HabitMode,
      key: fields[0] as String,
      reward: fields[7] as String?,
      when: fields[6] as String?,
      extendedGoal: fields[5] as int?,
    )
      ..imgUrl = fields[8] as String?
      ..imgY_Alignment = fields[9] as double;
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.mode)
      ..writeByte(3)
      ..write(obj.goal)
      ..writeByte(4)
      ..write(obj.dates)
      ..writeByte(5)
      ..write(obj.extendedGoal)
      ..writeByte(6)
      ..write(obj.when)
      ..writeByte(7)
      ..write(obj.reward)
      ..writeByte(8)
      ..write(obj.imgUrl)
      ..writeByte(9)
      ..write(obj.imgY_Alignment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HabitModeAdapter extends TypeAdapter<HabitMode> {
  @override
  final int typeId = 2;

  @override
  HabitMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HabitMode.major;
      case 1:
        return HabitMode.bonus;
      default:
        return HabitMode.major;
    }
  }

  @override
  void write(BinaryWriter writer, HabitMode obj) {
    switch (obj) {
      case HabitMode.major:
        writer.writeByte(0);
        break;
      case HabitMode.bonus:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
