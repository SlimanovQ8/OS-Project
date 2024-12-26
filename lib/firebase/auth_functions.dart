import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

Future updateCurrentUser() async {
  String? deviceID = "";
  if (Platform.isAndroid) {
    deviceID = await FirebaseMessaging.instance.getToken();

  }
  //

  final notificationSettings = await FirebaseMessaging.instance.requestPermission(

      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
  ).then((value) {
    debugPrint(value.toString());
  }).catchError((error) {
    debugPrint(error.toString());
  });
  FirebaseMessaging.instance.getNotificationSettings().then((value) {

  });
  print(notificationSettings);
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  debugPrint(apnsToken.toString());
  if (apnsToken != null) {
    // APNS token is available, make FCM plugin API requests...
    deviceID = await FirebaseMessaging.instance.getToken();
    debugPrint("aaaaaaaa");
  }
  bool isSignedIn =
       FirebaseAuth.instance.currentUser == null ? false : true;
  debugPrint(isSignedIn.toString());
  // ignore: curly_braces_in_flow_control_structures
  if (isSignedIn) {
    userID =  FirebaseAuth.instance.currentUser!.uid;
    isAnonymous =  FirebaseAuth.instance.currentUser!.isAnonymous;
    DocumentSnapshot doc = await usersCollection.doc(userID).get();
    if(doc.exists) {
      dynamic isAdmin = doc.get("isAdmin");
      if (isAdmin == true) {
        FirebaseMessaging.instance.subscribeToTopic("AdminNotifications").then((value) {
          debugPrint("Subscribed to Admin Notifications");
        }).catchError((error) {
          debugPrint(error.toString());
        });
      }
    }
    if (isAnonymous) {
      isAnonymous = true;
      userEmail = "";
      userPhone = "";
      if (userID != null) {
      } else {
        userID = "";
        isAnonymous = true;
        userEmail = "";
        userPhone = "";
      }
      // debugPrint(loggedUser);
    }
    // debugPrint(fcmToken);
    debugPrint(userID);
    debugPrint(isAnonymous.toString());
    if (!isAnonymous) {
      await usersCollection.doc(userID).get().then((value) {
        debugPrint("id" + value.id);
        loggedUser = user.fromDocument(value);
        userPhone = loggedUser.phoneNumber;
      }).catchError((error) {
         signOut();
      });
      await usersCollection.doc(userID).update({
        "deviceID": deviceID,
      });
      userEmail = FirebaseAuth.instance.currentUser!.email;
    } else if (isAnonymous) {
      await usersCollection.doc(userID).get().then((value) {
        loggedUser = user.fromDocument(value);
        userPhone = loggedUser.phoneNumber;
      }).catchError((error) {
        signOut();
      });
      await usersCollection.doc(userID).update({
        "deviceID": deviceID,
      });
    }
  } else {
    userID = "";
    isAnonymous = true;
    userEmail = "";
    userPhone = "";
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await updateCurrentUser();
}

Future<user> getCurrentUserInfo() async {
  // await usersCollection.get().then((value) {
  //
  //
  // });
  if (userID != null) {
    await usersCollection.doc(userID).get().then((value) {
      loggedUser = user.fromDocument(value);
    }).catchError((error) {
      debugPrint("Failed to get current user info : $error");
    });
  }
  // debugPrint(loggedUser);
  userPhone = loggedUser.phoneNumber;
  return loggedUser;
}
