import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';
import 'package:indriver_clone_flutter/src/domain/repository/DriverCarInfoRepository.dart';

class GetDriverCarInfoUseCase {

  DriverCarInfoRepository driverCarInfoRepository;
  GetDriverCarInfoUseCase(this.driverCarInfoRepository);
  run(int idDriver) => driverCarInfoRepository.getDriverCarInfo(idDriver);
}