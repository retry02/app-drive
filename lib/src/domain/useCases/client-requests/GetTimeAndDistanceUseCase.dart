import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

class GetTimeAndDistanceUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetTimeAndDistanceUseCase(this.clientRequestsRepository);

  run(
    double originLat, 
    double originLng, 
    double destinationLat, 
    double destinationLng
  ) => clientRequestsRepository.getTimeAndDistanceClientRequets(originLat, originLng, destinationLat, destinationLng);

}