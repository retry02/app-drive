import 'package:indriver_clone_flutter/src/domain/models/user.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

abstract class DriverCarInfoEvent {}

class DriverCarInfoInitEvent extends DriverCarInfoEvent {}

class BrandChanged extends DriverCarInfoEvent {
  final BlocFormItem brand;
  BrandChanged({ required this.brand });
}

class PlateChanged extends DriverCarInfoEvent {
  final BlocFormItem plate;
  PlateChanged({ required this.plate });
}

class ColorChanged extends DriverCarInfoEvent {
  final BlocFormItem color;
  ColorChanged({ required this.color });
}

class FormSubmit extends DriverCarInfoEvent {}