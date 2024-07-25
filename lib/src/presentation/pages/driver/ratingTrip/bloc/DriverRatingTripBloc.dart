import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/ratingTrip/bloc/DriverRatingTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/ratingTrip/bloc/DriverRatingTripState.dart';

class DriverRatingTripBloc extends Bloc<DriverRatingTripEvent, DriverRatingTripState> {
  ClientRequestsUseCases clientRequestsUseCases;
  DriverRatingTripBloc(this.clientRequestsUseCases): super(DriverRatingTripState()) {
    
    on<RatingChanged>((event, emit) {
      emit(
        state.copyWith(
          rating: event.rating
        )
      );  
    });

    on<UpdateRating>((event, emit) async {
      Resource response = await clientRequestsUseCases.updateClientRating.run(event.idClientRequest, state.rating);
      emit(
        state.copyWith(
          response: response
        )
      );
    });
  }
}