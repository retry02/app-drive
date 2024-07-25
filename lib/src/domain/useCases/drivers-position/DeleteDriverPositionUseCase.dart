
import 'package:indriver_clone_flutter/src/domain/models/DriverPosition.dart';
import 'package:indriver_clone_flutter/src/domain/repository/DriversPositionRepository.dart';

class DeleteDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  DeleteDriverPositionUseCase(this.driverPositionRepository);

  run(int idDriver) => driverPositionRepository.delete(idDriver);

}