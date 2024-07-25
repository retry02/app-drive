import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart';

class GetUserSessionUseCase {

  AuthRepository authRepository;

  GetUserSessionUseCase(this.authRepository);

  run() => authRepository.getUserSession();

}