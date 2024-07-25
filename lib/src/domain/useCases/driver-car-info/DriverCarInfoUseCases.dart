import 'package:indriver_clone_flutter/src/domain/useCases/driver-car-info/CreateDriverCarInfoUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-car-info/GetDriverCarInfoUseCase.dart';

class DriverCarInfoUseCases {

  CreateDriverCarInfoUseCase createDriverCarInfo;
  GetDriverCarInfoUseCase getDriverCarInfo;

  DriverCarInfoUseCases({
    required this.createDriverCarInfo,
    required this.getDriverCarInfo,
  });

}