String getChatRoomId(String userId1, String userId2) {
  // construct a chatroom ID for the 2 users
  List<String> ids = [userId1, userId2];
  ids.sort();
  String chatRoomId = ids.join('_');
  return chatRoomId;
}
