import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderName;
  final String message;
  final String receiverId;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.receiverId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'message': message,
      'receiverId': receiverId,
      'timestamp': timestamp,
    };
  }
}
