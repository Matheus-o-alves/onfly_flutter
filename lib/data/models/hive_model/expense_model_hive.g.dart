// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelHiveAdapter extends TypeAdapter<ExpenseModelHive> {
  @override
  final int typeId = 0;

  @override
  ExpenseModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModelHive(
      description: fields[0] as String,
      expenseDate: fields[1] as String,
      amount: fields[2] as double,
      latitude: fields[3] as String,
      longitude: fields[4] as String,
      indefier: fields[5] as int,
      isSync: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.expenseDate)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.indefier)
      ..writeByte(6)
      ..write(obj.isSync);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
