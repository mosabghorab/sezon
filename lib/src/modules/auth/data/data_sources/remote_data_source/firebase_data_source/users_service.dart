import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/auth/data/models/user.dart';

class UsersService {
  static UsersService? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // private constructor.
  UsersService._();

  // singleton pattern.
  static UsersService get instance =>
      _instance ?? (_instance = UsersService._());

  // create a user and get it.
  Future<AppUser?> createUser({
    required String uid,
    required String name,
    required String phone,
  }) async {
    try {
      await _firebaseFirestore
          .collection(Constants.firebaseFirestoreCollecitonUsers)
          .doc(uid)
          .set({
        'name': name,
        'phone': phone,
      });
      return await getUser(uid: uid);
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }

  // get a specific user.
  Future<AppUser?> getUser({
    required String uid,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firebaseFirestore
              .collection(Constants.firebaseFirestoreCollecitonUsers)
              .doc(uid)
              .get();
      return AppUser.fromJson(documentSnapshot.data()!);
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }
}
