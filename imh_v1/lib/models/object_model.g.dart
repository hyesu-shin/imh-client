// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObjectModelAdapter extends TypeAdapter<ObjectModel> {
  @override
  final int typeId = 0;

  @override
  ObjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ObjectModel(
      name: fields[0] as String,
      description: fields[1] as String,
      startDate: fields[2] as String,
      option: fields[3] as String?,
      dynamicFields: (fields[4] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, ObjectModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.option)
      ..writeByte(4)
      ..write(obj.dynamicFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
