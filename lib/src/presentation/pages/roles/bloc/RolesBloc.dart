import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/roles/bloc/RolesEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/roles/bloc/RolesState.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {

  AuthUseCases authUseCases;

  RolesBloc(this.authUseCases): super(RolesState()) {
    on<GetRolesList>((event, emit) async {
      AuthResponse? authResponse = await authUseCases.getUserSession.run();
      emit(
        state.copyWith(
          roles: authResponse?.user.roles
        )
      );
    });
  }

}