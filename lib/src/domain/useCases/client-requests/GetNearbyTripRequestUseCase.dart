import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

class GetNearbyTripRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetNearbyTripRequestUseCase(this.clientRequestsRepository);

  run(double driverLat, double driverLng) => clientRequestsRepository.getNearbyTripRequest(driverLat, driverLng);

}