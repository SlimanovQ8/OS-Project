import 'package:cloud_firestore/cloud_firestore.dart';
part 'workload.g.dart';
class Workload {

  String id;
  String name;
  List<String> sampleApps;
  Map<String, double> estimatedMahPerDevice;


  Workload({

    required this.id,
    required this.name,
    required this.sampleApps,
    required this.estimatedMahPerDevice,
  });


  factory Workload.fromJson(Map<String, dynamic> json) => _$WorkloadFromJson(json);
  Map<String, dynamic> toJson() => _$WorkloadToJson(this);
  factory Workload.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Workload.fromJson(data);
  }
}
