import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../models/chat.dart';

class ChatDao {
  
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.ref().child('messages');

  void saveMessage(ChatModel message, String senderId, String privatePostId) {
    _messagesRef.child(privatePostId).push().set(message.toJson());
  }

  // Query getMessageQuery() {
  //   return _messagesRef;
  // }

  Stream listenToMessages(String privatePostId) {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('messages');
    Stream stream;
    stream = databaseReference.child(privatePostId).onChildAdded;
    return stream;
  }
}
