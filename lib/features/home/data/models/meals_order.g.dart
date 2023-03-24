// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealsOrderAdapter extends TypeAdapter<MealsOrder> {
  @override
  final int typeId = 1;

  @override
  MealsOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealsOrder(
      meals: (fields[0] as List).cast<Meal>(),
      createdAt: fields[1] as String,
      isExecuted: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MealsOrder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.meals)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.isExecuted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealsOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
