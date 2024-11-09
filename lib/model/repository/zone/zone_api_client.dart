import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/model/dto/zone_dto.dart';
import 'package:f_journey/model/response/zone/get_all_response.dart';

class ZoneApiClient {
  const ZoneApiClient({required this.dio});
  final Dio dio;

  Future<GetAllZoneResponse> getAllZone() async {
    try {
      final response = await dio.get(ApiEndpoints.getZones);
      if (response.statusCode == 200) {
        return GetAllZoneResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get all zone');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ZoneDto>> filterZone(int fromZoneId) async {
    try {
      final response =
          await dio.get("${ApiEndpoints.filterZone}?fromZoneId=$fromZoneId");
      if (response.statusCode == 200) {
        return (response.data["result"]["zones"] as List)
            .map((e) => ZoneDto.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to filter zone');
      }
    } on DioException {
      rethrow;
    }
  }
}
