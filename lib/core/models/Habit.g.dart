// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Habit.dart';

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
      dates: (fields[2] as Map)?.cast<int, int>(),
      name: fields[1] as String,
      goal: fields[4] as int,
      mode: fields[3] as HabitMode,
      key: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dates)
      ..writeByte(3)
      ..write(obj.mode)
      ..writeByte(4)
      ..write(obj.goal);
  }
}
