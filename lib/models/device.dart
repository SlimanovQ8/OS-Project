import 'package:cloud_firestore/cloud_firestore.dart';
part 'device.g.dart';
class Device {

  String id;
  String brand;
  String model;
  Device({
    required this.id,
    required this.brand,
    required this.model,
  });


  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
  factory Device.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Device.fromJson(data);
  }
}