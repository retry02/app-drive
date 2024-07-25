abstract class DriverRatingTripEvent {}
class RatingChanged extends DriverRatingTripEvent {
  final double rating;
  RatingChanged({required this.rating});
}
class UpdateRating extends DriverRatingTripEvent {
  int idClientRequest;

  UpdateRating({required this.idClientRequest});
}