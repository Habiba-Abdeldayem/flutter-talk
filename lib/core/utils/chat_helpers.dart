import 'package:cloud_firestore/cloud_firestore.dart';

String getChatRoomId(String userId1, String userId2) {
  // construct a chatroom ID for the 2 users
  List<String> ids = [userId1, userId2];
  ids.sort();
  String chatRoomId = ids.join('_');
  return chatRoomId;
}

String formatTimestamp(Timestamp timestamp) {
  final dateTime = timestamp.toDate();
  final now = DateTime.now();

  if (now.difference(dateTime).inDays == 0) {
    // Same day
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  } else {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
