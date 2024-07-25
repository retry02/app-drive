import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/DriverTripRequestsService.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/repository/DriverTripRequestsRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class DriverTripRequestsRepositoryImpl implements DriverTripRequestsRepository {
  
  DriverTripRequestsService driverTripRequestsService;

  DriverTripRequestsRepositoryImpl(this.driverTripRequestsService);

  @override
  Future<Resource<bool>> create(DriverTripRequest driverTripRequest) {
    return driverTripRequestsService.create(driverTripRequest);
  }
  
  @override
  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest) {
    return driverTripRequestsService.getDriverTripOffersByClientRequest(idClientRequest);
  }

}