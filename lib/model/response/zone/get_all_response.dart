import 'package:f_journey/model/dto/zone_dto.dart';

class GetAllZoneResponse {
  bool success;
  GetAllZoneResult result;

  GetAllZoneResponse({
    required this.success,
    required this.result,
  });

  factory GetAllZoneResponse.fromJson(Map<String, dynamic> json) {
    return GetAllZoneResponse(
      success: json['success'],
      result: GetAllZoneResult.fromJson(json['result']),
    );
  }
}

class GetAllZoneResult {
  int page;
  int pageSize;
  int totalItems;
  int totalPages;
  List<ZoneDto> data;

  GetAllZoneResult({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.data,
  });

  factory GetAllZoneResult.fromJson(Map<String, dynamic> json) {
    return GetAllZoneResult(
      page: json['page'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      data: (json['data'] as List).map((e) => ZoneDto.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'totalItems': totalItems,
      'totalPages': totalPages,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
