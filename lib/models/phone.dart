import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'phone.g.dart';

@JsonSerializable()

class Phone {

  int batteryCapacity;
  int cpuFrequency;
  double height;
  String id;
  int maximumNits;
  int minimumNits;
  String name;
  String processor;
  int ram;
  double width;
  Phone({

    required this.batteryCapacity,
    required this.cpuFrequency,
    required this.height,
    required this.id,
    required this.maximumNits,
    required this.minimumNits,
    required this.name,
    required this.processor,
    required this.ram,
    required this.width,

  });


  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneToJson(this);
  factory Phone.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Phone.fromJson(data);
  }
}