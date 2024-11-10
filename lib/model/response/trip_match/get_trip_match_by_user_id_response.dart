import 'package:f_journey/model/dto/trip_match_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_trip_match_by_user_id_response.g.dart';

@JsonSerializable()
class GetTripMatchByUserIdResponse {
  String success;
  GetTripMatchByUserIdResult result;

  GetTripMatchByUserIdResponse({required this.success, required this.result});

  factory GetTripMatchByUserIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTripMatchByUserIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripMatchByUserIdResponseToJson(this);
}

@JsonSerializable()
class GetTripMatchByUserIdResult {
  int page;
  int pageSize;
  int totalItems;
  int totalPages;
  List<TripMatchDto> data;

  GetTripMatchByUserIdResult(
      {required this.page,
      required this.pageSize,
      required this.totalItems,
      required this.totalPages,
      required this.data});

  factory GetTripMatchByUserIdResult.fromJson(Map<String, dynamic> json) =>
      _$GetTripMatchByUserIdResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripMatchByUserIdResultToJson(this);
}
