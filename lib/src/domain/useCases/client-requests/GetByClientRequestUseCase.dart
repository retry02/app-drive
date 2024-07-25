import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

class GetByClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByClientRequestUseCase(this.clientRequestsRepository);

  run(int idClientRequest) => clientRequestsRepository.getByClientRequest(idClientRequest);

}