import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class GetPolylineUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPolylineUseCase(this.geolocatorRepository);

  run(LatLng pickUpLatLng, LatLng destinationLatLng) => geolocatorRepository.getPolyline(pickUpLatLng, destinationLatLng);
}