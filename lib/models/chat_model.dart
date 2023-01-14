import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
 String idFrom;
 String idTo;
 String timestamp;
 String content;
 int type;

 ChatMessages(
     {required this.idFrom,
     required this.idTo,
     required this.timestamp,
     required this.content,
     required this.type});

 Map<String, dynamic> toJson() {
   return {
     'idFrom': idFrom,
     'idTo': idTo,
     'timestamp': timestamp,
     'content': content,
     'type': type,
   };
 }

 factory ChatMessages.fromDocument(Map<String, dynamic> map) {
   String idFrom = map['idFrom'];
   String idTo = map['idTo'];
   String timestamp = map['timestamp'];
   String content = map['content'];
   int type = map['type'];

   return ChatMessages(
       idFrom: idFrom,
       idTo: idTo,
       timestamp: timestamp,
       content: content,
       type: type);
 }
}