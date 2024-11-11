import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/model/response/trip_match/get_trip_match_by_user_id_response.dart';

class TripMatchApiClient {
  final Dio dio;
  const TripMatchApiClient({required this.dio});

  Future<bool?> createTripMatch(int tripRequestId) async {
    try {
      final response = await dio.post(ApiEndpoints.createTripMatch, data: {
        "tripRequestId": tripRequestId,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create trip match');
      }
    } on DioException catch (e) {
      if (e.response?.data['result'] != null) {
        throw Exception(e.response?.data['result']);
      } else {
        rethrow;
      }
    }
  }

  Future<GetTripMatchByUserIdResponse> getTripMatchByDriverId(
      int driverId) async {
    try {
      final response =
          await dio.get(ApiEndpoints.getTripMatch, queryParameters: {
        "driverId": driverId,
        "pageSize": 100,
      });
      if (response.statusCode == 200) {
        return GetTripMatchByUserIdResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get trip match by user id');
      }
    } on DioException catch (e) {
      if (e.response?.data['result'] != null) {
        throw Exception(e.response?.data['result']);
      } else {
        rethrow;
      }
    }
  }

  Future<GetTripMatchByUserIdResponse> getAllTripMatch() async {
    try {
      final response =
          await dio.get(ApiEndpoints.getTripMatch, queryParameters: {
        "pageSize": 100,
      });
      if (response.statusCode == 200) {
        return GetTripMatchByUserIdResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get all trip match');
      }
    } on DioException catch (e) {
      if (e.response?.data['result'] != null) {
        throw Exception(e.response?.data['result']);
      } else {
        rethrow;
      }
    }
  }

  Future<bool> updateTripMatchStatus(int tripMatchId, String status,
      int? reasonId, bool isTripMatchUpdate) async {
    try {
      final response = await dio
          .put("${ApiEndpoints.udpateTripMatch}/$tripMatchId/status", data: {
        "status": status,
        "reasonId": reasonId,
        "isTripMatchUpdate": isTripMatchUpdate
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update trip match status');
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
