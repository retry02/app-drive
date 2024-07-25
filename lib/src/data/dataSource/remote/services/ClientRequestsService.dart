import 'dart:convert';

import 'package:indriver_clone_flutter/src/data/api/ApiConfig.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/ListToString.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
class ClientRequestsService {

  Future<Resource<int>> create(ClientRequest clientRequest) async {

    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(clientRequest);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(data);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }

  }

  Future<Resource<bool>> updateStatus(int idClientRequest, StatusTrip statusTrip) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/update_status');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode({
        'id_client_request': idClientRequest,
        'status': statusTrip.name,
      });
      final response = await http.put(url, headers: headers, body: body);
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

  Future<Resource<bool>> updateDriverRating(int idClientRequest, double rating) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/update_driver_rating');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode({
        'id_client_request': idClientRequest,
        'driver_rating': rating,
      });
      final response = await http.put(url, headers: headers, body: body);
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

  Future<Resource<bool>> updateClientRating(int idClientRequest, double rating) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/update_client_rating');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode({
        'id_client_request': idClientRequest,
        'client_rating': rating,
      });
      final response = await http.put(url, headers: headers, body: body);
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

  Future<Resource<bool>> updateDriverAssigned(int idClientRequest, int idDriver, double fareAssigned) async {

    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode({
        'id': idClientRequest,
        'id_driver_assigned': idDriver,
        'fare_assigned': fareAssigned
      });
      final response = await http.put(url, headers: headers, body: body);
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

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat, 
    double originLng, 
    double destinationLat, 
    double destinationLng
  ) async {

    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/${originLat}/${originLng}/${destinationLat}/${destinationLng}');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        TimeAndDistanceValues timeAndDistanceValues = TimeAndDistanceValues.fromJson(data);
        return Success(timeAndDistanceValues);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }

  }

  Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest(double driverLat, double driverLng) async {

    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/${driverLat}/${driverLng}');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ClientRequestResponse> clientRequests = ClientRequestResponse.fromJsonList(data);
        return Success(clientRequests);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }

  }

  Future<Resource<List<ClientRequestResponse>>> getByDriverAssigned(int idDriver) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/driver/assigned/$idDriver');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ClientRequestResponse> clientRequests = ClientRequestResponse.fromJsonList(data);
        return Success(clientRequests);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<List<ClientRequestResponse>>> getByClientAssigned(int idClient) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/client/assigned/$idClient');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ClientRequestResponse> clientRequests = ClientRequestResponse.fromJsonList(data);
        return Success(clientRequests);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
      
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<ClientRequestResponse>> getByClientRequest(int idClientRequest) async {

    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/client-requests/${idClientRequest}');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ClientRequestResponse clientRequests = ClientRequestResponse.fromJson(data);
        return Success(clientRequests);
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