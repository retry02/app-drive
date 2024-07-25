import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class DriverHistoryTripState extends Equatable {

  final Resource? response;

  DriverHistoryTripState({
    this.response
  });

   DriverHistoryTripState copyWith({
    Resource? response
   }) {
    return DriverHistoryTripState(response: response ?? this.response);
   }

   @override
  // TODO: implement props
  List<Object?> get props => [response];
}