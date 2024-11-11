import 'package:f_journey/model/repository/trip_match/trip_match_api_client.dart';
import 'package:f_journey/model/response/trip_match/get_trip_match_by_user_id_response.dart';

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

  Future<GetTripMatchByUserIdResult> getTripMatchByDriverId(
      int driverId) async {
    try {
      final response =
          await tripMatchApiClient.getTripMatchByDriverId(driverId);
      return response.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetTripMatchByUserIdResult> getAllTripMatch() async {
    try {
      final response = await tripMatchApiClient.getAllTripMatch();
      return response.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateTripMatchStatus(int tripMatchId, String status,
      int? reasonId, bool isTripMatchUpdate) async {
    try {
      return await tripMatchApiClient.updateTripMatchStatus(
          tripMatchId, status, reasonId, isTripMatchUpdate);
    } catch (e) {
      rethrow;
    }
  }
}
