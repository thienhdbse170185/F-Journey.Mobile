import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/model/request/trip_request/create_trip_request_request.dart';
import 'package:f_journey/model/response/trip_request/get_by_user_id.dart';

class TripRequestApiClient {
  final Dio dio;
  const TripRequestApiClient({required this.dio});

  Future<bool?> createTripRequest(CreateTripRequestRequest request) async {
    try {
      final response = await dio.post(ApiEndpoints.createTripRequest,
          data: request.toJson());
      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to create trip request');
      }
    } on DioException catch (e) {
      if (e.response?.data['result'] != null) {
        throw Exception(e.response?.data['result']);
      } else {
        rethrow;
      }
    }
  }

  Future<GetTripRequestByUserIdResponse> getTripRequestByUserId(
      int userId) async {
    try {
      final response = await dio.get(ApiEndpoints.getTripRequest,
          queryParameters: {'userId': userId, 'pageSize': 100});
      if (response.statusCode == 200) {
        return GetTripRequestByUserIdResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get trip request');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetTripRequestByUserIdResponse> getAllTripRequest() async {
    try {
      final response = await dio
          .get(ApiEndpoints.getTripRequest, queryParameters: {'pageSize': 100});
      if (response.statusCode == 200) {
        return GetTripRequestByUserIdResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get trip request');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> deleteTripRequest(int tripRequestId) async {
    try {
      final response =
          await dio.put("${ApiEndpoints.deleteTripRequest}/$tripRequestId");
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete trip request');
      }
    } on DioException catch (e) {
      if (e.response?.data['result'] != null) {
        throw Exception(e.response?.data['result']);
      } else {
        rethrow;
      }
    }
  }
}
