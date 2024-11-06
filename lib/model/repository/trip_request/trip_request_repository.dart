import 'package:f_journey/model/repository/trip_request/trip_request_api_client.dart';
import 'package:f_journey/model/request/trip_request/create_trip_request_request.dart';

class TripRequestRepository {
  final TripRequestApiClient apiClient;
  TripRequestRepository({required this.apiClient});

  Future<bool?> createTripRequest(CreateTripRequestRequest request) async {
    try {
      return await apiClient.createTripRequest(request);
    } catch (e) {
      rethrow;
    }
  }
}
