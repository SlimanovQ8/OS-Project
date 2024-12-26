// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDevice _$UserDeviceFromJson(Map<String, dynamic> json) => UserDevice(
      uuid: json['uuid'] as String,
      batteryHealth: json['batteryHealth'] as int,
      phone: Phone.fromJson(json['phone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDeviceToJson(UserDevice instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'batteryHealth': instance.batteryHealth,
      'phone': instance.phone.toJson(),
    };
