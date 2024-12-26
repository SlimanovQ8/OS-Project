import 'package:cloud_firestore/cloud_firestore.dart';
part 'custom_workload.g.dart';
class CustomWorkload {

  String id;
  String name;
  double totalBatteryDrain;
  double displayPowerConsumptionMw;
  double totalCPUPowerConsumptionMw;
  double totalPowerConsumptionMw;
  double networkPowerConsumptionMw;
  double wifiPowerConsumptionMw;
  double otherPowerConsumptionMw;

  CustomWorkload({

    required this.id,
    required this.name,
    required this.totalBatteryDrain,
    required this.displayPowerConsumptionMw,
    required this.totalCPUPowerConsumptionMw,
    required this.totalPowerConsumptionMw,
    required this.networkPowerConsumptionMw,
    required this.wifiPowerConsumptionMw,
    required this.otherPowerConsumptionMw,
  });


  factory CustomWorkload.fromJson(Map<String, dynamic> json) => _$CustomWorkloadFromJson(json);
  Map<String, dynamic> toJson() => _$CustomWorkloadToJson(this);
  factory CustomWorkload.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return CustomWorkload.fromJson(data);
  }
}
