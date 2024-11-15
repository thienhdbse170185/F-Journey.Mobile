import 'package:f_journey/model/dto/payment_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_payment_repsonse.g.dart';

@JsonSerializable()
class GetAllPaymentResponse {
  bool success;
  GetAllPaymentResult result;

  GetAllPaymentResponse({required this.success, required this.result});

  factory GetAllPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllPaymentRepsonseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllPaymentRepsonseToJson(this);
}

@JsonSerializable()
class GetAllPaymentResult {
  List<PaymentDto> items;
  int totalCount;
  int currentPage;
  int pageSize;
  bool hasPreviousPage;
  bool hasNextPage;
  int totalPages;

  GetAllPaymentResult({
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.totalPages,
  });

  factory GetAllPaymentResult.fromJson(Map<String, dynamic> json) =>
      _$GetAllPaymentResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllPaymentResultToJson(this);
}
