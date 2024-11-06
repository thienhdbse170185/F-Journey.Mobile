import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/features/trip/model/dto/zone_dto.dart';

class ZoneApiClient {
  const ZoneApiClient({required this.dio});
  final Dio dio;

  Future<List<ZoneDto>> getAllZone() async {
    try {
      final response = await dio.get(ApiEndpoints.getZones);
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => ZoneDto.fromJson(e)).toList();
      } else {
        throw Exception('Failed to get all zone');
      }
    } catch (e) {
      rethrow;
    }
  }
}
