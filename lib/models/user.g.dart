// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

user _$userFromJson(Map<String, dynamic> json) => user(
      createdAt:  json['createdAt'].toDate(),
      deviceID: json['deviceID'] as String,
      email: json['email'] as String,
      firstTime: json['firstTime'] as bool,
      id: json['id'] as String,
      isAdmin: json['isAdmin'] as bool,
      isGuest: json['isGuest'] as bool,
      lastLogin:  json['lastLogin'].toDate(),
      location: json['location'] as GeoPoint,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userPicture: json['userPicture'] as String,

);

Map<String, dynamic> _$userToJson(user instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'deviceID': instance.deviceID,
      'email': instance.email,
      'firstTime': instance.firstTime,
      'id': instance.id,
      'isAdmin': instance.isAdmin,
      'isGuest': instance.isGuest,
      'lastLogin': instance.lastLogin,
      'location': instance.location,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      "userPicture": instance.userPicture,
    };
