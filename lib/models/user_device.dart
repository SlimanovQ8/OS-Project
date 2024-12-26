// user_device.dart
import 'package:json_annotation/json_annotation.dart';
import 'phone.dart';

part 'user_device.g.dart';

@JsonSerializable()
class UserDevice {
  String uuid;
  Phone phone;
  int batteryHealth;

  UserDevice({
    required this.uuid,
    required this.phone,
    required this.batteryHealth,
  });

  factory UserDevice.fromJson(Map<String, dynamic> json) =>
      _$UserDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$UserDeviceToJson(this);
}
