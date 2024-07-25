import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';
import 'package:indriver_clone_flutter/src/domain/repository/DriverCarInfoRepository.dart';

class CreateDriverCarInfoUseCase {

  DriverCarInfoRepository driverCarInfoRepository;
  CreateDriverCarInfoUseCase(this.driverCarInfoRepository);
  run(DriverCarInfo driverCarInfo) => driverCarInfoRepository.create(driverCarInfo);
}