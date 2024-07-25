import 'package:geolocator/geolocator.dart';

abstract class DriverMapTripEvent {}

class InitDriverMapTripEvent extends DriverMapTripEvent {}

class GetClientRequest extends DriverMapTripEvent {
  final int idClientRequest;
  GetClientRequest({required this.idClientRequest});
}
class GetTimeAndDistanceValues extends DriverMapTripEvent {}

class AddPolyline extends DriverMapTripEvent {
  final String idPolyline;
  final double originLat;
  final double originLng;
  final double destinationLat;
  final double destinationLng;
  AddPolyline({
    required this.idPolyline,
    required this.originLat,
    required this.originLng,
    required this.destinationLat,
    required this.destinationLng,
  });
}

class ChangeMapCameraPosition extends DriverMapTripEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}
class AddMarkerPickup extends DriverMapTripEvent {
  final double lat;
  final double lng;
  AddMarkerPickup({
    required this.lat,
    required this.lng,
  });
}

class AddMarkerDestination extends DriverMapTripEvent {
  final double lat;
  final double lng;
  AddMarkerDestination({
    required this.lat,
    required this.lng,
  });
}

class RemoveMarker extends DriverMapTripEvent {
  final String idMarker;
  RemoveMarker({
    required this.idMarker
  });
}

class FindPosition extends DriverMapTripEvent {}
class UpdateLocation extends DriverMapTripEvent {
  final Position position;
  UpdateLocation({required this.position});
}
class StopLocation extends DriverMapTripEvent {}
class AddMyPositionMarker extends DriverMapTripEvent {
  final double lat;
  final double lng;
  AddMyPositionMarker({ required this.lat, required this.lng });
}
class EmitDriverPositionSocketIO extends DriverMapTripEvent {}
class EmitUpdateStatusSocketIO extends DriverMapTripEvent {}
class UpdateStatusToArrived extends DriverMapTripEvent {
}
class UpdateStatusToFinished extends DriverMapTripEvent {
}
