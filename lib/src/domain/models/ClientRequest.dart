import 'dart:convert';

ClientRequest clientRequestFromJson(String str) => ClientRequest.fromJson(json.decode(str));

String clientRequestToJson(ClientRequest data) => json.encode(data.toJson());


class ClientRequest {
    int? id;
    int idClient;
    double fareOffered;
    String pickupDescription;
    String destinationDescription;
    double pickupLat;
    double pickupLng;
    double destinationLat;
    double destinationLng;

    ClientRequest({
        this.id,
        required this.idClient,
        required this.fareOffered,
        required this.pickupDescription,
        required this.destinationDescription,
        required this.pickupLat,
        required this.pickupLng,
        required this.destinationLat,
        required this.destinationLng,
    });

    factory ClientRequest.fromJson(Map<String, dynamic> json) => ClientRequest(
        id: json["id"],
        idClient: json["id_client"],
        fareOffered: json["fare_offered"]?.toDouble(),
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
        pickupLat: json["pickup_lat"]?.toDouble(),
        pickupLng: json["pickup_lng"]?.toDouble(),
        destinationLat: json["destination_lat"]?.toDouble(),
        destinationLng: json["destination_lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "fare_offered": fareOffered,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "pickup_lat": pickupLat,
        "pickup_lng": pickupLng,
        "destination_lat": destinationLat,
        "destination_lng": destinationLng,
    };
}