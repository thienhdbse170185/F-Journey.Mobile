part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

final class WalletLoading extends WalletState {}

final class ImportWalletInProgress extends WalletState {}

final class ImportWalletSuccess extends WalletState {
  final String paymentUrl;

  ImportWalletSuccess(this.paymentUrl);
}

final class ImportWalletFailure extends WalletState {
  final String message;

  ImportWalletFailure(this.message);
}

final class CheckPaymentInProgress extends WalletState {}

final class CheckPaymentSuccess extends WalletState {
  final String message;

  CheckPaymentSuccess(this.message);
}

final class CheckPaymentFailure extends WalletState {
  final String message;

  CheckPaymentFailure(this.message);
}
