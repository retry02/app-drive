import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/CreateDriverTripRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/GetDriverTripOffersByClientRequestUseCase.dart';

class DriverTripRequestUseCases {

  CreateDriverTripRequestUseCase createDriverTripRequest;
  GetDriverTripOffersByClientRequestUseCase getDriverTripOffersByClientRequest;

  DriverTripRequestUseCases({
    required this.createDriverTripRequest,
    required this.getDriverTripOffersByClientRequest,
  });

}