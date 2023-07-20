import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/config/shared_data.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';

class UsersRepository {
  static UsersRepository? _instance;

  late final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // private constructor.
  UsersRepository._();

  // singleton pattern.
  static UsersRepository get instance =>
      _instance ?? (_instance = UsersRepository._());

  // create a user.
  Future<void> createUser({
    required String uid,
    required String name,
    required String phone,
  }) async {
    try {
      await _firebaseFirestore
          .collection(Constants.firebaseFirestoreCollectionUsers)
          .doc(uid)
          .set({
        'name': name,
        'phone': phone,
      });
    } catch (error) {
      // error.
      debugPrint('error : $error');
    }
  }

  // edit user.
  Future<AppUser?> editUser({
    required String name,
    String? avatar,
  }) async {
    try {
      await _firebaseFirestore
          .collection(Constants.firebaseFirestoreCollectionUsers)
          .doc(SharedData.currentUser!.uid)
          .update({
        'name': name,
        'avatar': avatar ?? SharedData.currentUser!.avatar,
      });
      return getUser(uid: SharedData.currentUser!.uid!);
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
              .collection(Constants.firebaseFirestoreCollectionUsers)
              .doc(uid)
              .get();
      return AppUser.fromJson(documentSnapshot.data()!)
        ..uid = documentSnapshot.id;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }

  // check user with phone.
  Future<bool?> checkUserWithPhone({
    required String phone,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection(Constants.firebaseFirestoreCollectionUsers)
          .where('phone', isEqualTo: phone)
          .limit(1)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }
}
