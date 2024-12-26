import 'dart:convert';

import 'package:b6arya/firebase/constants.dart';
import 'package:b6arya/models/device.dart';
import 'package:b6arya/models/phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
List<String> carsComp = [];
String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImN1c19SNE9KRUpXeEZvWlhSaiIsIm1vZXNpZlByaWNpbmdJZCI6InByaWNlXzFNUXF5dkJESWxQbVVQcE1NNWc2RmVvbyIsImlhdCI6MTcyOTQ5Mzc0MX0.YnTeNPQZRUDQF5as-1fO9f6-EvXl-TXfE3LNUpb5E5Q';
Future getDeviceAll() async {
  // final Map<String, dynamic> data = Map<String, dynamic>();
  // data["category"]= ["Smartphones"];
  // data["from"] = "2020-01-30";
  // data["brand"] = ["OnePlus"];
  // print(data);
  Map<String, dynamic> phones = {};
  List <String> phoneNames = [];
  for (var i = 0; i < 5; i++) {
    http.Response getOrderStatus = await http.get(
      Uri.parse('https://api.techspecs.io/v5/products/search/?category=Smartphones&brand=OnePlus&keepCasing=true&page=$i&size=10&from=2010-01-01&to=2024-01-01'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'accept': 'application/json',
        'x-api-id': '673f293ae9185a57f9b1e41d',
    'x-api-key': '14e0d269-363f-47bc-ba8c-b00ae1b6db8c'
      },
    );

    print(i);
    final Map<String, dynamic> statusBody = json.decode(getOrderStatus.body);
    int pageCount = statusBody['total_results_per_page'];


    for (var j = 0; j < pageCount; j++) {
      phones.putIfAbsent(
          statusBody["data"][j]['Product']['Model'], () => statusBody["data"][j]['Product']['id']);
      phoneNames.add(statusBody["data"][j]['Product']['Model']);
    }
    print(phoneNames.length);
    print(phones.length);
  }
  for (var i = 0; i < phones.length; i++) {
    await devicesCollection.doc(phones.keys.elementAt(i)).set(
      {
        'name': phones.keys.elementAt(i),
        'id': phones.values.elementAt((i)),
        'brand': 'OnePlus',
      }
    );
  }



  //List <String> carMakesList = getOrderStatus.body as List<String>;

}

Future getDeviceSpec() async {
  List <Device> appleModels = allDevices.where((device) => device.brand == 'OnePlus').toList();
  print(appleModels.length);
  //print(appleModels[76].model);
  for (var i = 0; i < appleModels.length; i++) {
    http.Response getOrderStatus = await http.get(
      Uri.parse('https://api.techspecs.io/v5/products/${appleModels[i].id}?lang=en&keepCasing=true'),
      headers: <String, String>{
        'accept': 'application/json',
        "Accept-Encoding": "gzip, deflate",
        'x-api-id': '673f293ae9185a57f9b1e41d',
    'x-api-key': '14e0d269-363f-47bc-ba8c-b00ae1b6db8c'

      },
    );

    final Map<String, dynamic> statusBody = json.decode(getOrderStatus.body);
    print(statusBody);
    String h= statusBody["data"]["Design"]["Body"]['Height'];
    String w= statusBody["data"]["Design"]["Body"]['Width'];
    Phone phone = Phone(
        batteryCapacity: statusBody["data"]["Inside"]["Battery"]['Capacity_mAh'],
        cpuFrequency: int.parse(statusBody["data"]["Inside"]["Processor"]['CPU Clock Speed'].replaceAll(RegExp('[^0-9]'), '')),
        height: double.parse(h.substring(0, h.indexOf('m'))),
        id: appleModels[i].id,
        maximumNits: 1200,
        minimumNits: 800,
        name: appleModels[i].model,
        processor: statusBody["data"]["Inside"]["Processor"]['CPU'],
        ram: int.parse(statusBody["data"]["Inside"]["RAM"]['Capacity'].replaceAll(RegExp('[^0-9]'), '')),
        width: double.parse(w.substring(0, w.indexOf('m'))),
    );
    await phonesCollection.doc(appleModels[i].model).set(phone.toJson());
    debugPrint(statusBody["data"]["Inside"]["Battery"].toString());
  }


  //List <String> carMakesList = getOrderStatus.body as List<String>;

}

void addDeviceSpec() async {

}