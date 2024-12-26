// user_device_functions.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_device.dart';

// Function to add a UserDevice to Firestore
Future<void> addUserDevice(UserDevice userDevice) async {
  // Reference to the 'user_devices' collection in Firestore
  CollectionReference userDevicesRef =
      FirebaseFirestore.instance.collection('user_devices');

  try {
    // Add the UserDevice to Firestore with the document ID as the uuid
    await userDevicesRef.doc(userDevice.uuid).set(userDevice.toJson());
    print('UserDevice with UUID ${userDevice.uuid} added successfully.');
  } catch (e) {
    print('Failed to add UserDevice: $e');
    // Handle the error appropriately in your app
  }
}

// Function to get a UserDevice from Firestore based on uuid
Future<UserDevice?> getUserDeviceByUuid(String uuid) async {
  // Reference to the 'user_devices' collection in Firestore
  CollectionReference userDevicesRef =
      FirebaseFirestore.instance.collection('user_devices');

  try {
    // Get the document with the specified uuid
    DocumentSnapshot doc = await userDevicesRef.doc(uuid).get();

    if (doc.exists) {
      // Convert the document data to a UserDevice object
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      UserDevice userDevice = UserDevice.fromJson(data);
      print('UserDevice with UUID $uuid retrieved successfully.');
      return userDevice;
    } else {
      print('No UserDevice found with UUID $uuid.');
      return null;
    }
  } catch (e) {
    print('Failed to get UserDevice: $e');
    // Handle the error appropriately in your app
    return null;
  }
}
