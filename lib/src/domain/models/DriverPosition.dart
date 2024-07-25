import 'dart:convert';

DriverPosition driverPositionFromJson(String str) => DriverPosition.fromJson(json.decode(str));

String driverPositionToJson(DriverPosition data) => json.encode(data.toJson());

class DriverPosition {
    int idDriver;
    double lat;
    double lng;

    DriverPosition({
        required this.idDriver,
        required this.lat,
        required this.lng,
    });

    factory DriverPosition.fromJson(Map<String, dynamic> json) => DriverPosition(
        idDriver: json["id_driver"],
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "lat": lat,
        "lng": lng,
    };
}
