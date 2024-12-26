import 'package:b6arya/models/phone.dart';
import 'package:b6arya/models/workload.dart';

import '../models/device.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

final usersCollection = FirebaseFirestore.instance.collection("Users");
final phonesCollection = FirebaseFirestore.instance.collection("Phones");
final emailCollection = FirebaseFirestore.instance.collection("Emails");
final devicesCollection = FirebaseFirestore.instance.collection("Devices");
final workloadsCollection = FirebaseFirestore.instance.collection("Workloads");
dynamic userID;
dynamic userEmail;
dynamic userPhone;
bool isAnonymous = false;
     String? selectedModel;
  bool isModelSelected = false;


late user loggedUser;


List<user> allUsers = [];
List<Device> allDevices = [];
List<Workload> allWorkloads = [];
List<Phone> allPhones = [];
List <String> phoneBrandList = ["Apple", "OnePlus", "Samsung"];
int userDeviceBrand = 0;
var allUsersSet = <String>{};
var allDevicesSet = <String>{};
var allPhonesSet = <String>{};
var allWorkloadsSet = <String>{};


String defaultPictureURL =
    "https://firebasestorage.googleapis.com/v0/b/rently-c357f.appspot.com/o/DefaultPicture%2FdefaultPic.png?alt=media&token=e1431cdf-38ed-4a5a-ad8d-e3e200e33c99";
