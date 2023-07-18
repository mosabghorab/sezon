import 'package:sezon/src/config/core/enums.dart';
import 'package:sezon/src/modules/auth/data/models/user.dart';

class SharedData {
//||... current_user ...||
  static AppUser? currentUser;

//||... app opened by ...||
  static AppOpenedBy appOpenedBy = AppOpenedBy.user;
}
