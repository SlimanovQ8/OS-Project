import 'package:b6arya/firebase/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/workload.dart';

 addWorkloadsToFirestore() async {
  // Create instances of Workload
  List<Workload> workloads = [
    Workload(
      id: '1',
      name: 'Social Media',
      sampleApps: ['Instagram', 'X', 'Snapchat'],
      estimatedMahPerDevice: {'OnePlus 11': 200.0},
    ),
    Workload(
      id: '2',
      name: 'Chatting',
      sampleApps: ['WhatsApp', 'Telegram'],
      estimatedMahPerDevice: {'OnePlus 11': 150.0},
    ),
    Workload(
      id: '3',
      name: 'Casual Games',
      sampleApps: ['Candy Crush', 'iKout'],
      estimatedMahPerDevice: {'OnePlus 11': 500.0},
    ),
    Workload(
      id: '4',
      name: 'Intensive Games',
      sampleApps: ['PUBG', 'COD'],
      estimatedMahPerDevice: {'OnePlus 11': 900.0},
    ),
  ];

  // Reference to the 'workloads' collection in Firestore
  CollectionReference workloadsRef =
      FirebaseFirestore.instance.collection('Workloads');

  // Add each Workload to Firestore
  for (Workload workload in workloads) {
    try {
      await workloadsRef.doc(workload.id).set(workload.toJson());
      print('Workload ${workload.name} added successfully.');
    } catch (e) {
      print('Failed to add workload ${workload.name}: $e');
    }
  }
}
Future<List<Workload>> getWorkloads({bool? isRefresh = false}) async {
  print('dyu,j');

  await workloadsCollection.get().then((value) {

    allWorkloads =
        value.docs.map((e) => Workload.fromJson(e.data())).where((
            element) => allWorkloadsSet.add(element.id)).toSet().toList();
  }).catchError((error) =>
      print("Failed to retrive properties list : $error"));

  print(allWorkloads.length);
  print("fg");
  return allWorkloads.toSet().toList();

}