// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workload _$WorkloadFromJson(Map<String, dynamic> json) {
  return Workload(
    id: json['id'] as String,
    name: json['name'] as String,
    sampleApps:
        (json['sampleApps'] as List<dynamic>).map((e) => e as String).toList(),
    estimatedMahPerDevice:
        (json['estimatedMahPerDevice'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, (e as num).toDouble()),
    ),
  );
}

Map<String, dynamic> _$WorkloadToJson(Workload instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sampleApps': instance.sampleApps,
      'estimatedMahPerDevice': instance.estimatedMahPerDevice,
    };
