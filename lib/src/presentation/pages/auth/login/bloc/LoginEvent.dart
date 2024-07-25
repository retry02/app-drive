import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

abstract class LoginEvent {}

class LoginInitEvent extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final BlocFormItem email;
  EmailChanged({ required this.email });
}

class PasswordChanged extends LoginEvent {
  final BlocFormItem password;
  PasswordChanged({ required this.password });
}

class SaveUserSession extends LoginEvent {
  final AuthResponse authResponse;
  SaveUserSession({ required this.authResponse });
}

class UpdateNotificationToken extends LoginEvent {
  final int id;
  UpdateNotificationToken({required this.id});
}

class FormSubmit extends LoginEvent {}