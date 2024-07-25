import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class DriverTripRequestsRepository {

  Future<Resource<bool>> create(DriverTripRequest driverTripRequest);
  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest);

}