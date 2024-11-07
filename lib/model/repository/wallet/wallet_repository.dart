import 'package:f_journey/model/repository/wallet/wallet_api_client.dart';
import 'package:f_journey/model/response/wallet/vnpay_response.dart';

class WalletRepository {
  final WalletApiClient walletApiClient;
  const WalletRepository({required this.walletApiClient});

  Future<String> updateWalletBalance(int balance) async {
    try {
      return await walletApiClient.updateWalletBalance(balance);
    } on Exception {
      rethrow;
    }
  }

  Future<String> checkPayment(VnpayResponse vnpayResponse) async {
    try {
      return await walletApiClient.checkPayment(vnpayResponse);
    } on Exception {
      rethrow;
    }
  }
}
