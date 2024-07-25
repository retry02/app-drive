import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class ClientDriverOffersState extends Equatable {

  final Resource? responseDriverOffers;
  final Resource? responseAssignDriver;

  ClientDriverOffersState({
    this.responseDriverOffers,
    this.responseAssignDriver
  });

  ClientDriverOffersState copyWith({
    Resource? responseDriverOffers,
    Resource? responseAssignDriver
  }) {
    return ClientDriverOffersState(
      responseDriverOffers: responseDriverOffers ?? this.responseDriverOffers,
      responseAssignDriver: responseAssignDriver
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [responseDriverOffers, responseAssignDriver];

}