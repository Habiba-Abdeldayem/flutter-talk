import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String content;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.content,
    required this.timestamp,
  });

  // convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      content: map['content'],
      timestamp: map['timestamp'],
    );
  }
}
