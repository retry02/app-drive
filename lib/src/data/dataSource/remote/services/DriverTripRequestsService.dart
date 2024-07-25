import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/ListToString.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class DriverTripRequestsService {

  Future<Resource<bool>> create(DriverTripRequest driverTripRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/driver-trip-offers');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(driverTripRequest);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

   Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest) async {

    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/driver-trip-offers/findByClientRequest/${idClientRequest}');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<DriverTripRequest> driverTripRequest = DriverTripRequest.fromJsonList(data);
        return Success(driverTripRequest);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }

   }

}