// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_workload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomWorkload _$CustomWorkloadFromJson(Map<String, dynamic> json) =>
    CustomWorkload(
      id: json['id'] as String,
      name: json['name'] as String,
      totalBatteryDrain: (json['totalBatteryDrain'] as num).toDouble(),
      displayPowerConsumptionMw:
      (json['displayPowerConsumptionMw'] as num).toDouble(),
      totalCPUPowerConsumptionMw:
      (json['totalCPUPowerConsumptionMw'] as num).toDouble(),
      totalPowerConsumptionMw:
      (json['totalPowerConsumptionMw'] as num).toDouble(),
      networkPowerConsumptionMw:
      (json['networkPowerConsumptionMw'] as num).toDouble(),
          wifiPowerConsumptionMw:
      (json['wifiPowerConsumptionMw'] as num).toDouble(),
      otherPowerConsumptionMw:
      (json['otherPowerConsumptionMw'] as num).toDouble(),
    );

Map<String, dynamic> _$CustomWorkloadToJson(CustomWorkload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'totalBatteryDrain': instance.totalBatteryDrain,
      'displayPowerConsumptionMw': instance.displayPowerConsumptionMw,
      'totalCPUPowerConsumptionMw': instance.totalCPUPowerConsumptionMw,
      'totalPowerConsumptionMw': instance.totalPowerConsumptionMw,
      'networkPowerConsumptionMw': instance.networkPowerConsumptionMw,
      'wifiPowerConsumptionMw': instance.wifiPowerConsumptionMw,
      'otherPowerConsumptionMw': instance.otherPowerConsumptionMw,
    };
