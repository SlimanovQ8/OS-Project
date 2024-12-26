import 'dart:io';

import 'package:b6arya/firebase/constants.dart';
import 'package:b6arya/models/phone.dart';
import 'package:b6arya/pages/startup/choose_phone.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import '../models/device.dart';

Future<List<Device>> getDevices({bool? isRefresh = false}) async {
  print('dyu,j');

  await devicesCollection.get().then((value) {

    allDevices =
        value.docs.map((e) => Device.fromJson(e.data())).where((
            element) => allDevicesSet.add(element.id)).toSet().toList();
  }).catchError((error) =>
      print("Failed to retrive properties list : $error"));

  print(allDevices.length);
  print("trygtujhfg");

  return allDevices.toSet().toList();

}
Future<List<Phone>> getPhones({bool? isRefresh = false}) async {
  print('dyu,j');

  await phonesCollection.get().then((value) {

    allPhones =
        value.docs.map((e) => Phone.fromJson(e.data())).where((
            element) => allPhonesSet.add(element.id)).toSet().toList();
  }).catchError((error) =>
      print("Failed to retrive properties list : $error"));

  print(allPhones.length);
  print("fg");
  return allPhones.toSet().toList();

}
List<Phone> myDevices = [];
Future<String> getDeviceID() async {
   String deviceID = "";
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

          if(Platform.isAndroid) {
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
              deviceID = androidInfo.id;
          }
          else if(Platform.isIOS) {
              IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
              deviceID = iosInfo.identifierForVendor!;
          }
          return deviceID;
}
retrieveCurrentDevice() async {
  myDevices.clear();
  final deviceMarketingNames = DeviceMarketingNames();
  final currentSingleDeviceName = await deviceMarketingNames.getSingleName();
      String singleDeviceName = currentSingleDeviceName;
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          String deviceCompany = "";
          if(Platform.isAndroid) {
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
              deviceCompany = androidInfo.manufacturer;
          }
          else if(Platform.isIOS) {
              IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
              deviceCompany = iosInfo.name;
          }
  print(deviceCompany);
  print('${singleDeviceName}');
    myDevices = allPhones.where((element) => element.name.contains(singleDeviceName)).toList();
    if(phoneBrandList.contains(deviceCompany)) {
      userDeviceBrand = phoneBrandList.indexOf(deviceCompany);
      print('trgfs/');
  }
    if(myDevices.isNotEmpty) {
      selectedModel = myDevices[0].name;
      isModelSelected = true;
    }
    print("index $userDeviceBrand");
  print(myDevices.length);
  print(allPhones.length);
}
int calculateActualCapacity({required int batteryHealth, required int batteryCapacity}) {
    double actualCapacity =  batteryHealth.toInt() / 100 * batteryCapacity.toInt();
    return actualCapacity.toInt();
  }