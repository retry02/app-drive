import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class ClientRequestsRepository {

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  );

  Future<Resource<int>> create(ClientRequest clientRequest);
  Future<Resource<bool>> updateStatus(int idClientRequest, StatusTrip statusTrip);
  Future<Resource<bool>> updateDriverRating(int idClientRequest, double rating);
  Future<Resource<bool>> updateClientRating(int idClientRequest, double rating);
  Future<Resource<bool>> updateDriverAssigned(int idClientRequest, int idDriver, double fareAssigned);
  Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest(double driverLat,double driverLng);
  Future<Resource<ClientRequestResponse>> getByClientRequest(int idClientRequest);
  Future<Resource<List<ClientRequestResponse>>> getByDriverAssigned(int idDriver);
  Future<Resource<List<ClientRequestResponse>>> getByClientAssigned(int idClient);

}