import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/model/response/wallet/vnpay_response.dart';

class WalletApiClient {
  final Dio dio;
  const WalletApiClient({required this.dio});

  Future<String> updateWalletBalance(int balance) async {
    try {
      final response = await dio.put(ApiEndpoints.updateWallet, data: {
        "balance": balance,
      });
      if (response.statusCode == 200) {
        return response.data['result'];
      } else {
        throw Exception('Failed to update wallet balance');
      }
    } on DioException {
      rethrow;
    }
  }

  Future<String> checkPayment(VnpayResponse vnpayResponse) async {
    try {
      final response = await dio
          .get('${ApiEndpoints.checkPayment}?${vnpayResponse.toString()}');
      if (response.statusCode == 200) {
        return response.data['result'] as String;
      }
    } on DioException {
      rethrow;
    }
    return '';
  }
}
