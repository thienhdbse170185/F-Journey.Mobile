import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/model/request/trip_request/create_trip_request_request.dart';

class TripRequestApiClient {
  final Dio dio;
  const TripRequestApiClient({required this.dio});

  Future<bool?> createTripRequest(CreateTripRequestRequest request) async {
    try {
      final response = await dio.post(ApiEndpoints.createTripRequest,
          data: request.toJson());
      if (response.statusCode == 200) {
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
}
