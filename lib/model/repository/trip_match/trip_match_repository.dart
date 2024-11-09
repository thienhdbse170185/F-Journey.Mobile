import 'package:f_journey/model/repository/trip_match/trip_match_api_client.dart';

class TripMatchRepository {
  final TripMatchApiClient tripMatchApiClient;

  TripMatchRepository({required this.tripMatchApiClient});

  Future<bool?> createTripMatch(int tripRequestId) async {
    try {
      return await tripMatchApiClient.createTripMatch(tripRequestId);
    } catch (e) {
      rethrow;
    }
  }
}
