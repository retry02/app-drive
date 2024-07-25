abstract class ClientMapTripEvent {}

class InitClientMapTripEvent extends ClientMapTripEvent {}

class GetClientRequest extends ClientMapTripEvent {
  final int idClientRequest;
  GetClientRequest({required this.idClientRequest});
}

class GetTimeAndDistanceValues extends ClientMapTripEvent {
  final double driverLat;
  final double driverLng;
  GetTimeAndDistanceValues({required this.driverLat, required this.driverLng});
}

class AddPolyline extends ClientMapTripEvent {
  final double driverLat;
  final double driverLng;
  final double destinationLat;
  final double destinationLng;
  AddPolyline({
    required this.driverLat, 
    required this.driverLng,
    required this.destinationLat,
    required this.destinationLng,
  });
}

class RemoveMarker extends ClientMapTripEvent {
  final String idMarker;
  RemoveMarker({
    required this.idMarker
  });
}

class ChangeMapCameraPosition extends ClientMapTripEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}
class AddMarkerPickup extends ClientMapTripEvent {
  final double lat;
  final double lng;
  AddMarkerPickup({
    required this.lat,
    required this.lng,
  });
}

class AddMarkerDestination extends ClientMapTripEvent {
  final double lat;
  final double lng;
  AddMarkerDestination({
    required this.lat,
    required this.lng,
  });
}

class AddMarkerDriver extends ClientMapTripEvent {
  final double lat;
  final double lng;
  AddMarkerDriver({
    required this.lat,
    required this.lng,
  });
}

class ListenTripNewDriverPosition extends ClientMapTripEvent {}
class ListenUpdateStatusClientRequestSocketIO extends ClientMapTripEvent {}
class SetDriverLatLng extends ClientMapTripEvent{
  final double lat;
  final double lng;
  SetDriverLatLng({
    required this.lat,
    required this.lng,
  });
}