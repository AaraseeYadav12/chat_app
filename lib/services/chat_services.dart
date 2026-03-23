import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SEND MESSAGE
  Future<void> sendMessage(String receiverId, String message) async {

    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;

    final Timestamp timestamp = Timestamp.now();

    // CREATE CHAT ROOM ID
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // MESSAGE DATA
    Map<String, dynamic> newMessage = {
      "senderId": currentUserId,
      "senderEmail": currentUserEmail,
      "receiverId": receiverId,
      "message": message,
      "timestamp": timestamp,
    };

    // ADD MESSAGE
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage);
  }

  // GET MESSAGES (REALTIME)
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}