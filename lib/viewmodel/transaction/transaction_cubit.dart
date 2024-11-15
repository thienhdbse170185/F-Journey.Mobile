import 'package:bloc/bloc.dart';
import 'package:f_journey/model/dto/payment_dto.dart';
import 'package:f_journey/model/repository/payment/payment_repository.dart';
import 'package:meta/meta.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final PaymentRepository paymentRepository;
  TransactionCubit(this.paymentRepository) : super(TransactionInitial());

  void getTransactionHistory() async {
    emit(TransactionLoading());
    try {
      final payments = await paymentRepository.getTransactionHistory();
      emit(GetAllTransactionSuccess(payments));
    } catch (e) {
      emit(GetAllTransactionFailure(e.toString()));
    }
  }
}
