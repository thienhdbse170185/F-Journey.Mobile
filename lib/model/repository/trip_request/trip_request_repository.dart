import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/model/repository/trip_request/trip_request_api_client.dart';
import 'package:f_journey/model/request/trip_request/create_trip_request_request.dart';
import 'package:f_journey/model/response/trip_request/get_by_user_id.dart';

class TripRequestRepository {
  final TripRequestApiClient apiClient;
  TripRequestRepository({required this.apiClient});

  Future<bool?> createTripRequest(CreateTripRequestRequest request) async {
    try {
      return await apiClient.createTripRequest(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TripRequestDto>> getTripRequestByUserId(int userId) async {
    try {
      GetTripRequestByUserIdResponse response =
          await apiClient.getTripRequestByUserId(userId);
      return response.result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> deleteTripRequest(int tripRequestId) async {
    try {
      return await apiClient.deleteTripRequest(tripRequestId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TripRequestDto>> getAllTripRequest() async {
    try {
      GetTripRequestByUserIdResponse response =
          await apiClient.getAllTripRequest();
      return response.result.data;
    } catch (e) {
      rethrow;
    }
  }
}
