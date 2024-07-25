import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/models/Role.dart';

class RolesState extends Equatable {

  final List<Role>? roles;

  const RolesState({
    this.roles
  });

  RolesState copyWith({
    List<Role>? roles
  }) {
    return RolesState(
      roles: roles
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [roles];

}