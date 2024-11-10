import 'package:bloc/bloc.dart';
import 'package:f_journey/model/dto/reason_dto.dart';
import 'package:f_journey/model/repository/reason/reason_repository.dart';
import 'package:meta/meta.dart';

part 'reason_state.dart';

class ReasonCubit extends Cubit<ReasonState> {
  final ReasonRepository _reasonRepository;
  ReasonCubit(this._reasonRepository) : super(ReasonInitial());

  void getAllReasons() async {
    emit(GetAllReasonInProgress());
    try {
      final reasons = await _reasonRepository.getReasons();
      emit(GetAllReasonSuccess(reasons: reasons));
    } catch (e) {
      emit(GetAllReasonFailure(message: e.toString()));
    }
  }
}
