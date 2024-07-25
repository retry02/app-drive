import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

abstract class DriverClientRequestsEvent {}

class InitDriverClientRequest extends DriverClientRequestsEvent{}
class GetNearbyTripRequest extends DriverClientRequestsEvent {}
class CreateDriverTripRequest extends DriverClientRequestsEvent {
  final DriverTripRequest driverTripRequest;
  CreateDriverTripRequest({required this.driverTripRequest});
}

class FareOfferedChange extends DriverClientRequestsEvent {
  final BlocFormItem fareOffered;
  FareOfferedChange({required this.fareOffered});
}

class ListenNewClientRequestSocketIO extends DriverClientRequestsEvent {}
class EmitNewDriverOfferSocketIO extends DriverClientRequestsEvent{
  final int idClientRequest;
  EmitNewDriverOfferSocketIO({required this.idClientRequest});
}