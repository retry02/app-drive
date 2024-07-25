
import 'package:indriver_clone_flutter/src/domain/repository/DriversPositionRepository.dart';

class GetDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  GetDriverPositionUseCase(this.driverPositionRepository);

  run(int idDriver) => driverPositionRepository.getDriverPosition(idDriver);
 
}