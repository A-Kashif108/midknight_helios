import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    MyUser u = MyUser(
        first_name: user.first_name,
        last_name: user.last_name,
        gender: user.gender,
        interested: user.interested,
        password: user.password,
        id: _auth.currentUser!.uid,
        url: user.url,
        email: user.email);
    await _db
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .set(u.toJson());
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
