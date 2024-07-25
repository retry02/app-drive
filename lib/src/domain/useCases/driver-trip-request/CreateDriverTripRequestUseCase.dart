import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/repository/DriverTripRequestsRepository.dart';

class CreateDriverTripRequestUseCase {

  DriverTripRequestsRepository driverTripRequestsRepository;

  CreateDriverTripRequestUseCase(this.driverTripRequestsRepository);

  run(DriverTripRequest driverTripRequest) => driverTripRequestsRepository.create(driverTripRequest);
}