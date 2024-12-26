

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';
import 'constants.dart';
List <String> fakeNames = ["Sulaiman", "Eissa", "Ahmed", "Mariam", "Ali", "Khaled", "Mahmoud", "Mustafa", "Abdelrahman", "Kholoud", "Sara", "Mohamed", "Ali", "Khaled", "Mahmoud", "Mustafa", "Abdelrahman"];
List <String> fakeEmails = ["fake1@fake.com", "fake2@fake.com", "fake3@fake.com", "fake4@fake.com", "fake5@fake.com", "fake6@fake.com", "fake7@fake.com", "fake8@fake.com", "fake9@fake.com", "fake10@fake.com", "fake11@fake.com", "fake12@fake.com", "fake13@fake.com", "fake14@fake.com"];
List <String> fakePhones = ["00000001", "00000002", "00000003", "00000004", "00000005", "00000006", "00000007", "00000008", "00000009", "00000010", "00000011", "00000012", "00000013", "00000014"];
addFakeUsers() async {

  DocumentSnapshot documentSnapshot = await emailCollection.doc(fakeEmails[1]).get();
  if(!documentSnapshot.exists) {
    List <user> fakeUsers = [];
    for (int i = 0; i < fakeEmails.length; i++) {
      user fakeUser = user(
          createdAt: DateTime.now(),
          deviceID: "deviceID",
          email: fakeEmails[i],
          firstTime: true,
          id: "id",
          isAdmin: false,
          isGuest: false,
          lastLogin: DateTime.now(),
          location: GeoPoint(0, 0),
          name: fakeEmails[i],
          phoneNumber: fakePhones[i],
          userPicture: defaultPictureURL
      );
      fakeUsers.add(fakeUser);
      try {

        final authResult =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: fakeUser.email, password: "00000000");

        await FirebaseAuth.instance.currentUser?.updateDisplayName(fakeUser.name);
        await FirebaseAuth.instance.currentUser
            ?.updatePhotoURL(defaultPictureURL );
        WriteBatch batch = FirebaseFirestore.instance.batch();
        var userDoc = usersCollection.doc(authResult?.user!.uid);
        var mobileDoc = phonesCollection.doc(fakeUser.phoneNumber);
        var emailDoc = emailCollection.doc(fakeUser.email.toLowerCase());
        fakeUser.id = authResult!.user!.uid;
        batch.set((userDoc), fakeUser.toJson());

        batch.set((mobileDoc), {
          'mobile': fakeUser.phoneNumber,
          "userID": authResult.user!.uid,
        });
        batch.set((emailDoc), {
          'email': fakeUser.email.toLowerCase(),
          "userID": authResult.user!.uid,

        });
        await batch.commit();

      } on FirebaseAuthException catch (e) {


      } catch (e) {


      }
    }
  }
}

Future<List<user>> getUsers({bool? isRefresh = false}) async {
  print('dyu,j');

      await usersCollection.get().then((value) {

        allUsers =
            value.docs.map((e) => user.fromJson(e.data())).where((
                element) => allUsersSet.add(element.id)).toSet().toList();
      }).catchError((error) =>
          print("Failed to retrive properties list : $error"));

    return allUsers.toSet().toList();

}