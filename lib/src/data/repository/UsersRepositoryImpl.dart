import 'dart:io';

import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/UsersService.dart';
import 'package:indriver_clone_flutter/src/domain/models/user.dart';
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class UsersRepositoryImpl implements UsersRepository {

  UsersService usersService;

  UsersRepositoryImpl(this.usersService);

  @override
  Future<Resource<User>> update(int id, User user, File? file) {
    if (file == null) {
      return usersService.update(id, user);
    }
    return usersService.updateImage(id, user, file);
  }
  
  @override
  Future<Resource<User>> updateNotificationToken(int id, String notificationToken) {
    return usersService.updateNotificationToken(id, notificationToken);
  }
}