import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

Future<String> uploadFile(
    {required String collection, required Uint8List filePath,required String docID, required String fileName}) async {

  try {
    final uploadTask = await FirebaseStorage.instance
        .ref()
        .child("$collection/$docID/$fileName")
        .putData(filePath)
        .whenComplete(() => null).catchError((e) {
      debugPrint(e.toString());
    });
    String url = await uploadTask.ref.getDownloadURL();
    return url;
  } catch (e) {
    debugPrint(e.toString());
  }
  return "0";
}