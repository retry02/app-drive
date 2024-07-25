import 'package:indriver_clone_flutter/src/domain/repository/DriverTripRequestsRepository.dart';

class GetDriverTripOffersByClientRequestUseCase {

  DriverTripRequestsRepository driverTripRequestsRepository;

  GetDriverTripOffersByClientRequestUseCase(this.driverTripRequestsRepository);

  run(int idClientRequest) => driverTripRequestsRepository.getDriverTripOffersByClientRequest(idClientRequest);

}