import 'package:sezon/src/config/core/enums.dart';

import '../modules/auth/models/app_user.dart';

class SharedData {
//||... current_user ...||
  static AppUser? currentUser;

//||... app opened by ...||
  static AppOpenedBy appOpenedBy = AppOpenedBy.user;
}
