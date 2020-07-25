// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../infrastructure/habit/Habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitModeAdapter extends TypeAdapter<HabitMode> {
  @override
  final typeId = 2;

  @override
  HabitMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HabitMode.Majror;
      case 1:
        return HabitMode.Bonus;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, HabitMode obj) {
    switch (obj) {
      case HabitMode.Majror:
        writer.writeByte(0);
        break;
      case HabitMode.Bonus:
        writer.writeByte(1);
        break;
    }
  }
}

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final typeId = 1;

  @override
  Habit read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      dates: (fields[4] as Map)?.cast<int, int>(),
      name: fields[1] as String,
      goal: fields[3] as int,
      mode: fields[2] as HabitMode,
      key: fields[0] as String,
      reward: fields[7] as String,
      when: fields[6] as String,
      extendedGoal: fields[5] as int,
    )
      ..imgUrl = fields[8] as String
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
}
