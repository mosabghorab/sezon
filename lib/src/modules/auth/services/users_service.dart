import 'package:sezon/src/modules/auth/data_sources/remote_data_source/firebase_data_source/users_repository.dart';
import 'package:sezon/src/modules/auth/models/app_user.dart';

class UsersService {
  // repository.
  late final UsersRepository _usersRepository = UsersRepository.instance;

  // create a user.
  Future<void> createUser({
    required String uid,
    required String name,
    required String phone,
  }) async {
    return _usersRepository.createUser(
      uid: uid,
      name: name,
      phone: phone,
    );
  }

  // edit user.
  Future<AppUser?> editUser({
    required String name,
    String? avatar,
  }) async {
    return _usersRepository.editUser(
      name: name,
      avatar: avatar,
    );
  }

  // get a specific user.
  Future<AppUser?> getUser({
    required String uid,
  }) async {
    return _usersRepository.getUser(uid: uid);
  }

  // check user with phone.
  Future<bool?> checkUserWithPhone({
    required String phone,
  }) async {
    return _usersRepository.checkUserWithPhone(phone: phone);
  }
}
