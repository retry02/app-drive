import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class DriverMapTripState extends Equatable {

  final Resource? responseGetClientRequest;
  final Completer<GoogleMapController>? controller;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final Resource? responseTimeAndDistance;
  final geolocator.Position? position;
  final ClientRequestResponse? clientRequestResponse;
  final StatusTrip? statusTrip;

  DriverMapTripState({
    this.responseGetClientRequest,
    this.controller,
    this.cameraPosition = const CameraPosition(target: LatLng(4.7449125, -74.1113708), zoom: 14.0),
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.responseTimeAndDistance,
    this.position,
    this.clientRequestResponse,
    this.statusTrip
  });

  DriverMapTripState copyWith({
    Resource? responseGetClientRequest,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    Resource? responseTimeAndDistance,
    geolocator.Position? position,
    int? idClient,
    ClientRequestResponse? clientRequestResponse,
    StatusTrip? statusTrip
  }) {
    return DriverMapTripState(
      responseGetClientRequest: responseGetClientRequest ?? this.responseGetClientRequest,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      responseTimeAndDistance: responseTimeAndDistance ?? this.responseTimeAndDistance,
      position: position ?? this.position,
      clientRequestResponse: clientRequestResponse ?? this.clientRequestResponse,
      statusTrip: statusTrip ?? this.statusTrip
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [clientRequestResponse, position, responseGetClientRequest, responseTimeAndDistance, controller, markers, polylines, cameraPosition, statusTrip];

}