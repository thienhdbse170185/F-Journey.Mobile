part of 'transaction_cubit.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class GetAllTransactionSuccess extends TransactionState {
  final List<PaymentDto> payments;

  GetAllTransactionSuccess(this.payments);
}

final class GetAllTransactionFailure extends TransactionState {
  final String error;

  GetAllTransactionFailure(this.error);
}
