import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

class GetByClientAssignedUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByClientAssignedUseCase(this.clientRequestsRepository);

  run(int idClient) => clientRequestsRepository.getByClientAssigned(idClient);

}