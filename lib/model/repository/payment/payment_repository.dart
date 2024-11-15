import 'package:f_journey/model/dto/payment_dto.dart';
import 'package:f_journey/model/repository/payment/payment_api_client.dart';

class PaymentRepository {
  final PaymentApiClient paymentApiClient;
  const PaymentRepository({required this.paymentApiClient});

  Future<List<PaymentDto>> getTransactionHistory() async {
    try {
      final response = await paymentApiClient.getAllPayment();
      return response.result.items;
    } catch (e) {
      rethrow;
    }
  }
}
