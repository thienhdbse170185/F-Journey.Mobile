import 'package:f_journey/features/trip/model/dto/zone_dto.dart';
import 'package:f_journey/features/trip/model/repository/zone_api_client.dart';

class ZoneRepository {
  final ZoneApiClient zoneApiClient;

  ZoneRepository(this.zoneApiClient);

  Future<List<ZoneDto>> getAllZone() async {
    try {
      return await zoneApiClient.getAllZone();
    } catch (e) {
      rethrow;
    }
  }
}
