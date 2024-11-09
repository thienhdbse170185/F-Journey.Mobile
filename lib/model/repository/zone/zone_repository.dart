import 'package:f_journey/model/dto/zone_dto.dart';
import 'package:f_journey/model/repository/zone/zone_api_client.dart';
import 'package:f_journey/model/response/zone/get_all_response.dart';

class ZoneRepository {
  final ZoneApiClient zoneApiClient;

  ZoneRepository({required this.zoneApiClient});

  Future<GetAllZoneResponse> getAllZone() async {
    try {
      return await zoneApiClient.getAllZone();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ZoneDto>> filterZone(int fromZoneId) async {
    try {
      return await zoneApiClient.filterZone(fromZoneId);
    } catch (e) {
      rethrow;
    }
  }
}
