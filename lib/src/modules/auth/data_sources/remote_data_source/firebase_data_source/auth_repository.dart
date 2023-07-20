import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sezon/src/modules/auth/data_sources/remote_data_source/firebase_data_source/users_repository.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';

class AuthRepository {
  static AuthRepository? _instance;

  late final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final UsersRepository _usersRepository = UsersRepository.instance;

  // private constructor.
  AuthRepository._();

  // singleton pattern.
  static AuthRepository get instance =>
      _instance ?? (_instance = AuthRepository._());

  // send code.
  Future<void> sendCode({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    return await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // sign in with phone.
  Future<AppUser?> signInWithPhone({
    required String verificationId,
    required String smsCode,
    String? name,
    String? phone,
  }) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user == null ||
          userCredential.user!.phoneNumber == null) {
        print(userCredential.user);
        print(userCredential.user!.phoneNumber);
        return null;
      }
      AppUser? user =
          await _usersRepository.getUser(uid: userCredential.user!.uid);
      if (user == null) {
        await _usersRepository.createUser(
            uid: userCredential.user!.uid, name: name!, phone: phone!);
        return await _usersRepository.getUser(uid: userCredential.user!.uid);
      } else {
        return user;
      }
      // success.
    } catch (error) {
      // error.
      debugPrint('error : $error');
      return null;
    }
  }

  // sign out.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
