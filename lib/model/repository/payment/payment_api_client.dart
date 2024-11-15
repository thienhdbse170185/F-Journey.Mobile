import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/model/response/payment/get_all_payment_response.dart';

class PaymentApiClient {
  final Dio dio;
  const PaymentApiClient({required this.dio});

  Future<GetAllPaymentResponse> getAllPayment() async {
    try {
      final response = await dio.get(ApiEndpoints.getTransactionHistory,
          queryParameters: {'pageSize': 100});
      if (response.statusCode == 200) {
        return GetAllPaymentResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load payment');
      }
    } on DioException catch (e) {
      rethrow;
    }
  }
}
