import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()

class user {

  DateTime createdAt;
  String deviceID;
  String email;
  bool firstTime;
  String id;
  bool isAdmin;
  bool isGuest;
  DateTime lastLogin;
  GeoPoint location;
  String name;
  String phoneNumber;
  String userPicture;


  user({
    required this.createdAt,

    required this.deviceID,
    required this.email,
    required this.firstTime,
    required this.id,
    required this.isAdmin,
    required this.isGuest,
    required this.lastLogin,
    required this.location,
    required this.name,
    required this.phoneNumber,
    required this.userPicture,


  });


  factory user.fromJson(Map<String, dynamic> json) => _$userFromJson(json);
  Map<String, dynamic> toJson() => _$userToJson(this);
  factory user.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return user.fromJson(data);
  }
}