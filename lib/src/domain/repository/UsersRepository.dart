import 'dart:io';

import 'package:indriver_clone_flutter/src/domain/models/user.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class UsersRepository {

  Future<Resource<User>> update(int id, User user, File? file);
  Future<Resource<User>> updateNotificationToken(int id, String notificationToken);

}