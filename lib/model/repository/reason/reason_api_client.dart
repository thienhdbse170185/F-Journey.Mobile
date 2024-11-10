import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/model/response/reason/reason_response.dart';

class ReasonApiClient {
  final Dio dio;
  ReasonApiClient({required this.dio});

  Future<ReasonResponse> getReasons() async {
    try {
      final response = await dio.get(ApiEndpoints.getReasons);
      if (response.statusCode == 200) {
        return ReasonResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to load reasons");
      }
    } on DioException catch (e) {
      rethrow;
    }
  }
}
