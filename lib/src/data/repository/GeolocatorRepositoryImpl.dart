import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/data/api/ApiKeyGoogle.dart';
import 'package:indriver_clone_flutter/src/domain/models/PlacemarkData.dart';
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class GeolocatorRepositoryImpl implements GeolocatorRepository {
  @override
  Future<Position> findPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('La ubicacion no esta activada');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Permiso no otorgado por el usuario');
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      print('Permiso no otorgado por el usuario permanentemente');
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(configuration, path);
    return descriptor;
  }

  @override
  Marker getMarker(String markerId, double lat, double lng, String title, String content, BitmapDescriptor imageMarker) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: imageMarker,
      position: LatLng(lat,lng),
      infoWindow: InfoWindow(title: title, snippet: content)
    );
    return marker;
  }

  @override
  Future<PlacemarkData?> getPlacemarkData(CameraPosition cameraPosition) async {
    try {
      double lat = cameraPosition.target.latitude;
      double lng = cameraPosition.target.longitude;
      List<Placemark> placemarkList = await placemarkFromCoordinates(lat, lng);
      if (placemarkList != null) {
        if (placemarkList.length > 0) {
          String direction = placemarkList[0].thoroughfare!;
          String street = placemarkList[0].subThoroughfare!;
          String city = placemarkList[0].locality!;
          String department = placemarkList[0].administrativeArea!;
          PlacemarkData placemarkData = PlacemarkData(
            address: '$direction, $street, $city, $department', 
            lat: lat, 
            lng: lng
          );
          return placemarkData;
        }
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  
  @override
  Future<List<LatLng>> getPolyline(LatLng pickUpLatLng, LatLng destinationLatLng) async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        API_KEY_GOOGLE,
        PointLatLng(pickUpLatLng.latitude, pickUpLatLng.longitude),
        PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Bogota, Colombia")]);
    List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    return polylineCoordinates;
  }
  
  @override
  Stream<Position> getPositionStream() {
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 1
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

}