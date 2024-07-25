import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/main.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart' as TD;
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/bloc/ClientMapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/bloc/ClientMapTripState.dart';

class ClientMapTripBloc extends Bloc<ClientMapTripEvent, ClientMapTripState> {

  Timer? timer;
  BlocSocketIO blocSocketIO;
  ClientRequestsUseCases clientRequestsUseCases;
  GeolocatorUseCases geolocatorUseCases;
  AuthUseCases authUseCases;

  ClientMapTripBloc(this.blocSocketIO, this.clientRequestsUseCases, this.geolocatorUseCases, this.authUseCases): super(ClientMapTripState()) {

    on<InitClientMapTripEvent>((event, emit) async {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(
        state.copyWith(
          controller: controller,
        )
      );
    });
    
    on<AddMarkerPickup>((event, emit) async {
      BitmapDescriptor pickUpDescriptor = await geolocatorUseCases.createMarker.run('assets/img/person_location.png');
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
        'pickup',
        event.lat,
        event.lng,
        'Lugar de recogida',
        'Debes permancer aqui mientras llega el conductor',
        pickUpDescriptor
      );
      emit(
        state.copyWith(
          markers: Map.of(state.markers)..[markerPickUp.markerId] = markerPickUp
        )
      );
    });

    on<AddMarkerDestination>((event, emit) async {
      BitmapDescriptor destinationDescriptor = await geolocatorUseCases.createMarker.run('assets/img/red_flag.png');
      Marker marker = geolocatorUseCases.getMarker.run(
        'destination',
        event.lat,
        event.lng,
        'Lugar de destino',
        '',
        destinationDescriptor
      );
      emit(
        state.copyWith(
          markers: Map.of(state.markers)..[marker.markerId] = marker
        )
      );
    });

    on<AddMarkerDriver>((event, emit) async{
      BitmapDescriptor driverDescriptor = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
      Marker marker = geolocatorUseCases.getMarker.run(
        'driver',
        event.lat,
        event.lng,
        'Tu conductor',
        '',
        driverDescriptor
      );
      emit(
        state.copyWith(
          markers: Map.of(state.markers)..[marker.markerId] = marker
        )
      );
    });

    on<AddPolyline>((event, emit) async {
      List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline.run(
        LatLng(event.driverLat, event.driverLng), 
        LatLng(event.destinationLat, event.destinationLng)
      );
      PolylineId id = PolylineId("MyRoute");
      Polyline polyline = Polyline(
        polylineId: id, 
        color: Colors.blueAccent, 
        points: polylineCoordinates,
        width: 6
      );
      emit(
        state.copyWith(
          polylines: {
            id: polyline
          },
          isRouteDrawed: true
        )
      );
    });

     on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController = await state.controller!.future;
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 12,
            bearing: 0
          )
        ));
      } catch (e) {
        print('Error ChangeMapCameraPosition: $e');
      }
    });  

    on<GetClientRequest>((event, emit) async {
      Resource response = await clientRequestsUseCases.getByClientRequest.run(event.idClientRequest);
      emit(
        state.copyWith(
          responseGetClientRequest: response
        )
      );
      if (response is Success) {
        final data = response.data as ClientRequestResponse;
        emit(
          state.copyWith(
            clientRequestResponse: data
          )
        );
        add(ListenUpdateStatusClientRequestSocketIO());
      }
    });

    on<GetTimeAndDistanceValues>((event, emit) async {
      Resource response = await clientRequestsUseCases.getTimeAndDistance.run(
        event.driverLat,
        event.driverLng,
        state.clientRequestResponse!.pickupPosition.y,
        state.clientRequestResponse!.pickupPosition.x,
      );
      if (response is Success) {
        final data = response.data as TD.TimeAndDistanceValues; 
        print('Time and Distance: ${data.toJson()}');
        emit(
          state.copyWith(
            timeAndDistanceValues: data
          )
        );
      }
    });
    
    on<SetDriverLatLng>((event, emit) {
      emit(
        state.copyWith(
          driverLatLng: LatLng(event.lat, event.lng)
        )
      );
      add(AddMarkerDriver(
        lat: state.driverLatLng!.latitude,
        lng: state.driverLatLng!.longitude
      ));
      if (!state.isRouteDrawed) {
        add(
          AddPolyline(
            driverLat: state.driverLatLng!.latitude, 
            driverLng: state.driverLatLng!.longitude,
            destinationLat: state.clientRequestResponse!.pickupPosition.y,
            destinationLng: state.clientRequestResponse!.pickupPosition.x,
          )
        );
        add(
          GetTimeAndDistanceValues(
            driverLat: state.driverLatLng!.latitude, 
            driverLng: state.driverLatLng!.longitude
          )
        );
        timer = Timer.periodic(Duration(minutes: 1), (timer) {            
          add(
            GetTimeAndDistanceValues(
              driverLat: state.driverLatLng!.latitude, 
              driverLng: state.driverLatLng!.longitude
            )
          );
        });
      }
    });

    on<ListenTripNewDriverPosition>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      blocSocketIO.state.socket?.on('trip_new_driver_position/${authResponse.user.id}', (data) {
        add(
          SetDriverLatLng(
            lat: data['lat'] as double, 
            lng: data['lng'] as double
          )
        );
      });
    });

    on<ListenUpdateStatusClientRequestSocketIO>((event, emit) {
      blocSocketIO.state.socket?.on('new_status_trip/${state.clientRequestResponse!.id}', (data) {
        String statusTrip = data['status'] as String;
        if (statusTrip == StatusTrip.ARRIVED.name) {
          timer?.cancel();
          add(
            AddPolyline(
              driverLat: state.driverLatLng!.latitude, 
              driverLng: state.driverLatLng!.longitude, 
              destinationLat: state.clientRequestResponse!.destinationPosition.y, 
              destinationLng: state.clientRequestResponse!.destinationPosition.x
            )
          );
          add(RemoveMarker(idMarker: 'pickup'));
          add(
            AddMarkerDestination(
              lat: state.clientRequestResponse!.destinationPosition.y, 
              lng: state.clientRequestResponse!.destinationPosition.x
            )
          );
        }
        else if (statusTrip == StatusTrip.FINISHED.name) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil('client/rating/trip', (route) => false, arguments: state.clientRequestResponse);
        }
      });
    });

    on<RemoveMarker>((event, emit) {
      emit(
        state.copyWith(
          markers: Map.of(state.markers)..remove(MarkerId(event.idMarker))
        )
      );
    });

  } 

}