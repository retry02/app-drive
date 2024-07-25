import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

abstract class DriverCarInfoRepository {

  Future<Resource<bool>> create(DriverCarInfo driverCarInfo);
  Future<Resource<DriverCarInfo>> getDriverCarInfo(int idDriver);

}