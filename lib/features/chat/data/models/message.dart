import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String text;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.timestamp,
  });

  // convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'content': text,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      text: map['text'],
      timestamp: map['timestamp'],
    );
  }
}
