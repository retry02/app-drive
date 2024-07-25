import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';

class GetMarkerUseCase {
  GeolocatorRepository geolocatorRepository;
  GetMarkerUseCase(this.geolocatorRepository);
  run(String markerId, double lat, double lng, String title, String content, BitmapDescriptor imageMarker) => geolocatorRepository.getMarker(markerId, lat, lng, title, content, imageMarker);
}