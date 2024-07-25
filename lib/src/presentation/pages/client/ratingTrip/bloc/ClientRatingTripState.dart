import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class ClientRatingTripState extends Equatable {

  final double rating;
  final Resource? response;

  ClientRatingTripState({
    this.rating = 0,
    this.response
  });

  ClientRatingTripState copyWith({
    double? rating,
    Resource? response
  }) {
    return ClientRatingTripState(
      rating: rating ?? this.rating,
      response: response
    );
  }

  @override
  List<Object?> get props => [rating, response];

}