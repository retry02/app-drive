import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';

class CreateClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  CreateClientRequestUseCase(this.clientRequestsRepository);

  run(ClientRequest clientRequest) => clientRequestsRepository.create(clientRequest);

}