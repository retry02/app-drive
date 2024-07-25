import 'dart:convert';

import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';
import 'package:indriver_clone_flutter/src/domain/models/user.dart';

DriverTripRequest driverTripRequestFromJson(String str) => DriverTripRequest.fromJson(json.decode(str));

String driverTripRequestToJson(DriverTripRequest data) => json.encode(data.toJson());

class DriverTripRequest {
    int? id;
    int idDriver;
    int idClientRequest;
    double fareOffered;
    double time;
    double distance;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? driver;
    DriverCarInfo? car;
    
    DriverTripRequest({
        this.id,
        required this.idDriver,
        required this.idClientRequest,
        required this.fareOffered,
        required this.time,
        required this.distance,
        this.createdAt,
        this.updatedAt,
        this.driver,
        this.car
    });

    factory DriverTripRequest.fromJson(Map<String, dynamic> json) => DriverTripRequest(
        id: json["id"],
        idDriver: json["id_driver"],
        idClientRequest: json["id_client_request"],
        fareOffered: json["fare_offered"] is String ? double.parse(json["fare_offered"]) : json["fare_offered"],
        time: json["time"] is String ? double.parse(json["time"]) : json["time"],
        distance: json["distance"] is String ? double.parse(json['distance']) : json['distance'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        driver: User.fromJson(json["driver"]),
        car: DriverCarInfo.fromJson(json["car"]),
    );

    static List<DriverTripRequest> fromJsonList(List<dynamic> jsonList) {
      List<DriverTripRequest> toList = [];
      jsonList.forEach((json) { 
        DriverTripRequest driverTripRequest = DriverTripRequest.fromJson(json);
        toList.add(driverTripRequest);
      });
      return toList;
    }

    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "id_client_request": idClientRequest,
        "fare_offered": fareOffered,
        "time": time,
        "distance": distance,
    };
}

