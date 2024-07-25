import 'package:indriver_clone_flutter/src/domain/useCases/users/UpdateNotificationTokenUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UpdateUserUseCase.dart';

class UsersUseCases {

  UpdateUserUseCase update;
  UpdateNotificationTokenUseCase updateNotificationToken;

  UsersUseCases({
    required this.update,
    required this.updateNotificationToken,
  });

}