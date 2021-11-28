import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<QuerySnapshot<Map<String, dynamic>>> getUserByName(
      String fName) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .where("firstName", isEqualTo: fName)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserByEmail(
      String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("user").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String ChatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(ChatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String ChatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(ChatRoomId)
        .collection("chats")
        .snapshots();
  }
}
