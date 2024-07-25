import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

abstract class ClientMapBookingInfoEvent {}

class ClientMapBookingInfoInitEvent extends ClientMapBookingInfoEvent {
  final LatLng pickUpLatLng;
  final LatLng destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  ClientMapBookingInfoInitEvent({
    required this.pickUpLatLng,
    required this.destinationLatLng,
    required this.pickUpDescription,
    required this.destinationDescription,
  });
}

class FareOfferedChanged extends ClientMapBookingInfoEvent {
  final BlocFormItem fareOffered;

  FareOfferedChanged({required this.fareOffered});
}

class ChangeMapCameraPosition extends ClientMapBookingInfoEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}
class CreateClientRequest extends ClientMapBookingInfoEvent {}
class GetTimeAndDistanceValues extends ClientMapBookingInfoEvent {}
class AddPolyline extends ClientMapBookingInfoEvent {}
class EmitNewClientRequestSocketIO extends ClientMapBookingInfoEvent {
  final int idClientRequest;
  EmitNewClientRequestSocketIO({required this.idClientRequest}); 
}
