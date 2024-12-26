// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
      batteryCapacity: json['batteryCapacity'] as int,
      cpuFrequency: json['cpuFrequency'] as int,
      height: json['height'] as double,
      id: json['id'] as String,
      maximumNits: json['maximumNits'] as int,
      minimumNits: json['minimumNits'] as int,
      name: json['name'] as String,
      processor: json['processor'] as String,
      ram: json['ram'] as int,
      width: json['width'] as double,


);

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'batteryCapacity': instance.batteryCapacity,
      'cpuFrequency': instance.cpuFrequency,
      'height': instance.height,
      'id': instance.id,
      'maximumNits': instance.maximumNits,
      'minimumNits': instance.minimumNits,
      'name': instance.name,
      'ram': instance.ram,
      'processor': instance.processor,
      'width': instance.width,
      // Add other fields if necessary
    };
