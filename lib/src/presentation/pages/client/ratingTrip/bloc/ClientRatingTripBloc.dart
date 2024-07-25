import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripState.dart';


class ClientRatingTripBloc extends Bloc<ClientRatingTripEvent, ClientRatingTripState> {
  ClientRequestsUseCases clientRequestsUseCases;
  ClientRatingTripBloc(this.clientRequestsUseCases): super(ClientRatingTripState()) {
    
    on<RatingChanged>((event, emit) {
      emit(
        state.copyWith(
          rating: event.rating
        )
      );  
    });

    on<UpdateRating>((event, emit) async {
      Resource response = await clientRequestsUseCases.updateDriverRating.run(event.idClientRequest, state.rating);
      emit(
        state.copyWith(
          response: response
        )
      );
    });
  }
}