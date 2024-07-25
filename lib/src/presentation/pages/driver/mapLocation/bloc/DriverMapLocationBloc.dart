import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverPosition.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/drivers-position/DriversPositionUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationState.dart';
import 'package:socket_io_client/socket_io_client.dart';


class DriverMapLocationBloc extends Bloc<DriverMapLocationEvent, DriverMapLocationState> {

  SocketUseCases socketUseCases;
  GeolocatorUseCases geolocatorUseCases;
  AuthUseCases authUseCases;
  DriversPositionUseCases driversPositionUseCases;
  StreamSubscription? positionSubscription;
  BlocSocketIO blocSocketIO;
  
  DriverMapLocationBloc(this.blocSocketIO, this.geolocatorUseCases, this.socketUseCases, this.authUseCases, this.driversPositionUseCases): super(DriverMapLocationState()) {
    
    on<DriverMapLocationInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      emit(
        state.copyWith(
          controller: controller,
          idDriver: authResponse.user.id
        )
      );
    });
    
    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));
      Stream<Position> positionStream = geolocatorUseCases.getPositionStream.run();
      positionSubscription = positionStream.listen((Position position) {
        add(UpdateLocation(position: position));
        add(SaveLocationData(
          driverPosition: DriverPosition(
            idDriver: state.idDriver!, 
            lat: position.latitude, 
            lng: position.longitude)
          )
        );
      });
      emit(
        state.copyWith(
          position: position,
        )
      );
    });

    on<AddMyPositionMarker>((event, emit) async {
      BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
      Marker marker = geolocatorUseCases.getMarker.run(
        'my_location',
        event.lat,
        event.lng,
        'Mi posicion',
        '',
        descriptor
      );
      emit(
        state.copyWith(
          markers: {
            marker.markerId: marker
          },
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

    on<UpdateLocation>((event, emit) async {
      add(AddMyPositionMarker(lat: event.position.latitude, lng: event.position.longitude));
      add(ChangeMapCameraPosition(lat: event.position.latitude, lng: event.position.longitude));
      emit(
        state.copyWith(
          position: event.position
        )
      );
      add(EmitDriverPositionSocketIO());
    });

    on<StopLocation>((event, emit) {
      positionSubscription?.cancel();
       add(DeleteLocationData(idDriver: state.idDriver!));
    });

    on<EmitDriverPositionSocketIO>((event, emit) async {
      blocSocketIO.state.socket?.emit('change_driver_position', {
        'id': state.idDriver,
        'lat': state.position!.latitude,
        'lng': state.position!.longitude,
      });
    });

    on<SaveLocationData>((event, emit) async {
      await driversPositionUseCases.createDriverPosition.run(event.driverPosition);
    }); 

    on<DeleteLocationData>((event, emit) async {
      await driversPositionUseCases.deleteDriverPosition.run(event.idDriver);
    });

  }


}