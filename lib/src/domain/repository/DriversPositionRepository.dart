import 'package:indriver_clone_flutter/src/domain/models/DriverPosition.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class DriverPositionRepository {

  Future<Resource<bool>> create(DriverPosition driverPosition);
  Future<Resource<bool>> delete(int idDriver);
  Future<Resource<DriverPosition>> getDriverPosition(int idDriver);

}