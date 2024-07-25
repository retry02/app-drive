import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

class UpdateStatusClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  UpdateStatusClientRequestUseCase(this.clientRequestsRepository);

  run(int idClientRequest, StatusTrip statusTrip) => clientRequestsRepository.updateStatus(idClientRequest, statusTrip);

}