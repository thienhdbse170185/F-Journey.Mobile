import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';

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
}
