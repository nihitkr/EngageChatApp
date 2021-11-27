import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByName(String fName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("firstName", isEqualTo: fName)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }
}
