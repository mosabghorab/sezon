import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class FirebaseStorageManager {
  static FirebaseStorageManager? _instance;
  late final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // private constructor.
  FirebaseStorageManager._();

  // singleton pattern.
  static FirebaseStorageManager get instance =>
      _instance ?? (_instance = FirebaseStorageManager._());

  Future<String?> uploadFile({
    required File file,
  }) async {
    try {
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}-${basename(file.path)}';
      Reference firebaseStorageRef = _firebaseStorage.ref().child(fileName);
      UploadTask uploadTask =
          firebaseStorageRef.putData(await file.readAsBytes());
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (error) {
      debugPrint("error : $error");
      return null;
    }
  }
}
