import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class ClientHistoryTripState extends Equatable {

  final Resource? response;

  ClientHistoryTripState({
    this.response
  });

   ClientHistoryTripState copyWith({
    Resource? response
   }) {
    return ClientHistoryTripState(response: response ?? this.response);
   }

   @override
  // TODO: implement props
  List<Object?> get props => [response];
}