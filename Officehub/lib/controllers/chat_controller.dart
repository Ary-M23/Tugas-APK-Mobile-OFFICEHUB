import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Officehub/models/chatmodel.dart';

class ChatService extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    try {
      final String currentUserInfo = firebaseAuth.currentUser!.uid;
      final String currentUserDisplayName =
          firebaseAuth.currentUser!.displayName!;
      final Timestamp timestamp = Timestamp.now();

      //Create new message
      Message newMessage = Message(
        senderId: currentUserInfo,
        senderName: currentUserDisplayName,
        message: message,
        receiverId: receiverId,
        timestamp: timestamp,
      );

      //construct chat room id from current user id and receiver id (sorted to ensure consistency)
      List<String> ids = [currentUserInfo, receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      await _fireStore
          .collection('chatrooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());
    } catch (e) {
      // Handle the error here
      print('Error sending message: $e');
    }
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _fireStore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
