import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/src/domain/models/PlacemarkData.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ClientMapSeekerBloc extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {

  GeolocatorUseCases geolocatorUseCases;
  SocketUseCases socketUseCases;
  BlocSocketIO blocSocketIO;
  

  ClientMapSeekerBloc(this.blocSocketIO,this.geolocatorUseCases, this.socketUseCases): super(ClientMapSeekerState()) {
    on<ClientMapSeekerInitEvent>((event, emit) {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(
        state.copyWith(
          controller: controller
        )
      );
    });
    
    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      emit(
        state.copyWith(
          position: position,
        )
      );
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController = await state.controller!.future;
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 13,
            bearing: 0
          )
        ));
      } catch (e) {
        print('ERROR EN ChangeMapCameraPosition: $e');
      }
      
    });  

    on<OnCameraMove>((event, emit) {
      emit(
        state.copyWith(
          cameraPosition: event.cameraPosition
        )
      );
    });

    on<OnCameraIdle>((event, emit) async {
      try {
        PlacemarkData placemarkData = await geolocatorUseCases.getPlacemarkData.run(state.cameraPosition);
        emit(
          state.copyWith(
            placemarkData: placemarkData
          )
        );  
      } catch (e) {
        print('OnCameraIdle Error: $e');
      }
      
    });

    on<OnAutoCompletedPickUpSelected>((event, emit) {
      emit(
        state.copyWith(
          pickUpLatLng: LatLng(event.lat, event.lng),
          pickUpDescription: event.pickUpDescription
        )
      );
    });

    on<OnAutoCompletedDestinationSelected>((event, emit) {
      emit(
        state.copyWith(
          destinationLatLng: LatLng(event.lat, event.lng),
          destinationDescription: event.destinationDescription
        )
      );
    });


    on<ListenDriversPositionSocketIO>((event, emit) async {
      if (blocSocketIO.state.socket != null ) {
        blocSocketIO.state.socket?.on('new_driver_position', (data) {
          add(
            AddDriverPositionMarker(
              idSocket: data['id_socket'] as String, 
              id: data['id'] as int, 
              lat: data['lat'] as double, 
              lng: data['lng'] as double
            )
          );
        });
      }
    });

    on<ListenDriversDisconnectedSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null ) {
        blocSocketIO.state.socket?.on('driver_disconnected', (data) {
          print('Id: ${data['id_socket']}');
          add(RemoveDriverPositionMarker(idSocket: data['id_socket'] as String));
        });
      }
    });

    on<RemoveDriverPositionMarker>((event, emit) {
      emit(
          state.copyWith(
            markers: Map.of(state.markers)..remove(MarkerId(event.idSocket))
          )
        );
    });

    on<AddDriverPositionMarker>((event, emit) async {
      BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
      Marker marker = geolocatorUseCases.getMarker.run(
        event.idSocket,
        event.lat,
        event.lng,
        'Conductor disponible',
        '',
        descriptor
      );
      emit(
        state.copyWith(
          markers: Map.of(state.markers)..[marker.markerId] = marker
        )
      );
    });

  }

}