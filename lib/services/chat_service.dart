import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_model.dart';

class ChatService{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessage(String groupChatId) {
 return firebaseFirestore
     .collection('Messages')
     .doc(groupChatId)
     .collection(groupChatId)
     .orderBy('timestamp', descending: true)
     .snapshots();
}
void sendChatMessage(String content, int type, String groupChatId,
   String currentUserId, String peerId) {
 DocumentReference documentReference = firebaseFirestore
     .collection('Messages')
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