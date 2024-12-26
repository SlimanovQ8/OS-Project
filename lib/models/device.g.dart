// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      brand: json['brand'] as String,
      id: json['id'] as String,
      model: json['name'] as String,


);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'brand': instance.brand,
      'id': instance.id,
      'name': instance.model,
      // Add other fields if necessary
    };
