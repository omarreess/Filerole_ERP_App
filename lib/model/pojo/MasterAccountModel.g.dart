// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MasterAccountModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterAccountModelAdapter extends TypeAdapter<MasterAccountModel> {
  @override
  final int typeId = 0;

  @override
  MasterAccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MasterAccountModel(
      name: fields[5] as String?,
      email: fields[8] as String?,
      phoneNumber: fields[9] as String?,
      address: fields[10] as String?,
      subscriptions: fields[12] as String?,
      id: fields[4] as String?,
      img: fields[2] as String?,
      domain: fields[1] as String?,
      endpoint: fields[11] as String?,
      storeName: fields[0] as String?,
      firstName: fields[7] as String?,
      lastName: fields[6] as String?,
      accessToken: fields[3] as String?,
      userType: fields[13] as String?,
      password: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MasterAccountModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.storeName)
      ..writeByte(1)
      ..write(obj.domain)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.accessToken)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.lastName)
      ..writeByte(7)
      ..write(obj.firstName)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.phoneNumber)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.endpoint)
      ..writeByte(12)
      ..write(obj.subscriptions)
      ..writeByte(13)
      ..write(obj.userType)
      ..writeByte(14)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterAccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
