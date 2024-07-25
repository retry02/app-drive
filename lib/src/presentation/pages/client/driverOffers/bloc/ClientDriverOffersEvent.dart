import 'package:flutter/material.dart';

abstract class ClientDriverOffersEvent {}

class GetDriverOffers extends ClientDriverOffersEvent{
  final int idClientRequest;

  GetDriverOffers({required this.idClientRequest});
}
class ListenNewDriverOfferSocketIO extends ClientDriverOffersEvent {
  final int idClientRequest;
  ListenNewDriverOfferSocketIO({required this.idClientRequest});
}

class AssignDriver extends ClientDriverOffersEvent {
  final int idClientRequest;
  final int idDriver;
  final double fareAssigned;
  final BuildContext context;
  AssignDriver({required this.idClientRequest, required this.idDriver, required this.fareAssigned, required this.context});
}

class EmitNewClientRequestSocketIO extends ClientDriverOffersEvent {
  final int idClientRequest;
  EmitNewClientRequestSocketIO({required this.idClientRequest}); 
}

class EmitNewDriverAssignedSocketIO extends ClientDriverOffersEvent {
  final int idClientRequest;
  final int idDriver;
  EmitNewDriverAssignedSocketIO({required this.idClientRequest, required this.idDriver}); 
}


