import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/chat_model.dart';

class ChatService{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> updateFirestoreData(
   String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
 return firebaseFirestore
     .collection(collectionPath)
     .doc(docPath)
     .update(dataUpdate);
}


UploadTask uploadImageFile(File image, String filename) {
 Reference reference = firebaseStorage.ref().child(filename);
 UploadTask uploadTask = reference.putFile(image);
 return uploadTask;
}

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessage(String groupChatId) {
 return firebaseFirestore
     .collection('Chats')
     .doc(groupChatId)
     .collection(groupChatId)
     .orderBy('timestamp', descending: true)
     .snapshots();
}
void sendChatMessage(String content, int type, String groupChatId,
   String currentUserId, String peerId) {
 DocumentReference documentReference = firebaseFirestore
     .collection('Chats')
     .doc(groupChatId)
     .collection(groupChatId)
     .doc(DateTime.now().millisecondsSinceEpoch.toString());
 ChatMessages chatMessages = ChatMessages(
     idFrom: currentUserId,
     idTo: peerId,
     timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
     content: content,
     type: type);

 FirebaseFirestore.instance.runTransaction((transaction) async {
   transaction.set(documentReference, chatMessages.toJson());
 });
}
}