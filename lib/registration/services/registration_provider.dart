import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:sign_up/registration/models/user_model.dart';

class RegistrationProvider extends ChangeNotifier {
  // final databaseReference = FirebaseDatabase.instance.reference();
  final collection = FirebaseFirestore.instance.collection("user");

  Future<bool> register(UserModel userModel, File? filePath) async {
    await collection.doc(userModel.phoneno).set(userModel.toJson());
    if (filePath != null) {
      uploadFile(File(filePath.path));
    }
    return true;
  }

  Future<String> uploadFile(File file) async {
    String fileName = path.basename(file.path);
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  UserModel userDetails = UserModel();
  Future<bool> fetchData(String userId) async {
    final collection = FirebaseFirestore.instance.collection('user');
    final snapshot = await collection.doc(userId).get();
    userDetails = UserModel.fromJson(snapshot.data()!);

   return true;
  }
}
