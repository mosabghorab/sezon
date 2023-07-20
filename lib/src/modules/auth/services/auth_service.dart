import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/auth/data_sources/remote_data_source/firebase_data_source/auth_repository.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';

class AuthService extends GetxService {
  // repository.
  late final AuthRepository _authRepository = AuthRepository.instance;

  // send code.
  Future<void> sendCode({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    return await _authRepository.sendCode(
      phoneNumber: phoneNumber,
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
    return _authRepository.signInWithPhone(
      verificationId: verificationId,
      smsCode: smsCode,
      name: name,
      phone: phone,
    );
  }

  // sign out.
  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
