import 'dart:convert';

DriverCarInfo driverCarInfoFromJson(String str) => DriverCarInfo.fromJson(json.decode(str));

String driverCarInfoToJson(DriverCarInfo data) => json.encode(data.toJson());

class DriverCarInfo {
    int? idDriver;
    String brand;
    String plate;
    String color;

    DriverCarInfo({
        this.idDriver,
        required this.brand,
        required this.plate,
        required this.color,
    });

    factory DriverCarInfo.fromJson(Map<String, dynamic> json) => DriverCarInfo(
        idDriver: json["id_driver"],
        brand: json["brand"],
        plate: json["plate"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "brand": brand,
        "plate": plate,
        "color": color,
    };
}