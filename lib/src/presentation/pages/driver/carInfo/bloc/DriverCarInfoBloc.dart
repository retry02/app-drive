import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-car-info/DriverCarInfoUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

class DriverCarInfoBloc extends Bloc<DriverCarInfoEvent, DriverCarInfoState> {

  AuthUseCases authUseCases;
  DriverCarInfoUseCases driverCarInfoUseCases;
  final formKey = GlobalKey<FormState>();

  DriverCarInfoBloc(this.authUseCases, this.driverCarInfoUseCases): super(DriverCarInfoState()) {
    
    on<DriverCarInfoInitEvent>((event, emit) async {
      emit(
        state.copyWith(
          formKey: formKey
        )
      );
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource response = await driverCarInfoUseCases.getDriverCarInfo.run(authResponse.user.id!);
      if (response is Success) {
        final driverCarInfo = response.data as DriverCarInfo;
         emit(
          state.copyWith(
            idDriver: authResponse.user.id!,
            brand: BlocFormItem(
              value: driverCarInfo.brand
            ),
            plate: BlocFormItem(
              value: driverCarInfo.plate
            ),
            color: BlocFormItem(
              value: driverCarInfo.color
            ),
            formKey: formKey
          )
        );
      }
     
    });
    on<BrandChanged>((event, emit) {
      emit(
        state.copyWith(
          brand: BlocFormItem(
            value: event.brand.value,
            error: event.brand.value.isEmpty ? 'Ingresa la marca' : null
          ),
          formKey: formKey
        )
      );
    });
    on<PlateChanged>((event, emit) {
      emit(
        state.copyWith(
          plate: BlocFormItem(
            value: event.plate.value,
            error: event.plate.value.isEmpty ? 'Ingresa la placa del vehiculo' : null
          ),
          formKey: formKey
        )
      );
    });
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(
          color: BlocFormItem(
            value: event.color.value,
            error: event.color.value.isEmpty ? 'Ingresa el color del vehiculo' : null
          ),
          formKey: formKey
        )
      );
    });
    
    on<FormSubmit>((event, emit) async {
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );
      Resource response = await driverCarInfoUseCases.createDriverCarInfo.run(
        DriverCarInfo(
          idDriver: state.idDriver,
          brand: state.brand.value, 
          plate: state.plate.value, 
          color: state.color.value
        )
      );
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    });
  }

}