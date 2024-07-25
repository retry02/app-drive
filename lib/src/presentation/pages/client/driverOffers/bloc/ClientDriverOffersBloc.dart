import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';

class ClientDriverOffersBloc extends Bloc<ClientDriverOffersEvent, ClientDriverOffersState> {

  BlocSocketIO blocSocketIO;
  DriverTripRequestUseCases driverTripRequestUseCases;
  ClientRequestsUseCases clientRequestsUseCases;

  ClientDriverOffersBloc(this.blocSocketIO, this.driverTripRequestUseCases, this.clientRequestsUseCases): super(ClientDriverOffersState()) {
    on<GetDriverOffers>((event, emit) async {
      Resource<List<DriverTripRequest>> response = await driverTripRequestUseCases.getDriverTripOffersByClientRequest.run(event.idClientRequest);
      emit(
        state.copyWith(
          responseDriverOffers: response
        )
      );
    });

    on<ListenNewDriverOfferSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on('created_driver_offer/${event.idClientRequest}', (data) {
          add(GetDriverOffers(idClientRequest: event.idClientRequest));
        });
      }
    });

    on<AssignDriver>((event, emit) async {
      Resource<bool> response = await clientRequestsUseCases.updateDriverAssigned.run(event.idClientRequest, event.idDriver, event.fareAssigned);
      emit(
        state.copyWith(
          responseAssignDriver: response
        )
      );
      if (response is Success) {
        add(EmitNewClientRequestSocketIO(idClientRequest: event.idClientRequest));
        add(EmitNewDriverAssignedSocketIO(
          idClientRequest: event.idClientRequest,
          idDriver: event.idDriver
        ));
      }
    });

    on<EmitNewClientRequestSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.emit('new_client_request', {
            'id_client_request': event.idClientRequest
        });
      }
    });

    on<EmitNewDriverAssignedSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.emit('new_driver_assigned', {
            'id_client_request': event.idClientRequest,
            'id_driver': event.idDriver
        });
      }
    });

  }

}