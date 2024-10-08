// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbolsearch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SymbolSearchModelAdapter extends TypeAdapter<SymbolSearchModel> {
  @override
  final int typeId = 1;

  @override
  SymbolSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SymbolSearchModel(
      symbol: fields[0] as String,
      name: fields[1] as String,
      region: fields[2] as String,
      currency: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SymbolSearchModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.region)
      ..writeByte(3)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymbolSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
