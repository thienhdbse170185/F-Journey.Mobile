import 'package:f_journey/model/dto/reason_dto.dart';
import 'package:f_journey/model/repository/reason/reason_api_client.dart';

class ReasonRepository {
  final ReasonApiClient reasonApiClient;

  ReasonRepository({required this.reasonApiClient});

  Future<List<ReasonDto>> getReasons() async {
    try {
      final response = await reasonApiClient.getReasons();
      return response.result;
    } catch (e) {
      rethrow;
    }
  }
}
