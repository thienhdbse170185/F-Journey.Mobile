import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_by_user_id.g.dart';

@JsonSerializable()
class GetTripRequestByUserIdResponse {
  bool success;
  GetTripRequestByUserIdResult result;

  GetTripRequestByUserIdResponse({
    required this.success,
    required this.result,
  });

  factory GetTripRequestByUserIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTripRequestByUserIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripRequestByUserIdResponseToJson(this);
}

@JsonSerializable()
class GetTripRequestByUserIdResult {
  int page;
  int pageSize;
  int totalItems;
  int totalPages;
  List<TripRequestDto> data;

  GetTripRequestByUserIdResult({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.data,
  });

  factory GetTripRequestByUserIdResult.fromJson(Map<String, dynamic> json) =>
      _$GetTripRequestByUserIdResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripRequestByUserIdResultToJson(this);
}
