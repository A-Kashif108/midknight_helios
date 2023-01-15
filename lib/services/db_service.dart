import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:midknight_helios/models/khat_model.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

class DBService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadFile(File? photo) async {
    if (photo == null) return null;
    final fileName = basename(photo.path);
    final destination = 'files/$fileName';

    try {
      final ref = _storage.ref(destination).child('file/');
      await ref.putFile(photo);
      return await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
    return null;
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future createUser(MyUser user) async {
    await _db
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .set(user.toJson());
    await _db.collection('Users').doc(_auth.currentUser!.uid).update({
      'id': _auth.currentUser!.uid,
      'sent_khats': [],
      'received_khats': [],
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getKhats() {
    return _db
        .collection('Khats')
        .where('receiverId', isEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }

  Future<List<String>> getInterestsIds() async {
    MyUser user = await getUser();
    QuerySnapshot snapshot = await _db
        .collection('Users')
        .where('Gender', isEqualTo: user.interested)
        .get();
    return snapshot.docs.map((e) {
      return e.id;
    }).toList();
  }

  Future sendKhat(KhatModel khat) async {
    await _db.collection('Khats').add(khat.toJson());
  }

  Future<MyUser> getUser() async {
    MyUser user = await _db
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((snapshot) {
      final data = snapshot.data();
      return MyUser.fromJSON(data!);
    });
    return user;
  }
}
