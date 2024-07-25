abstract class ClientRatingTripEvent {}
class RatingChanged extends ClientRatingTripEvent {
  final double rating;
  RatingChanged({required this.rating});
}
class UpdateRating extends ClientRatingTripEvent {
  int idClientRequest;

  UpdateRating({required this.idClientRequest});
}