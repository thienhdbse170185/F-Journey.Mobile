import 'package:bloc/bloc.dart';
import 'package:f_journey/model/repository/trip_match/trip_match_repository.dart';
import 'package:meta/meta.dart';

part 'trip_match_state.dart';

class TripMatchCubit extends Cubit<TripMatchState> {
  final TripMatchRepository repository;
  TripMatchCubit({required this.repository}) : super(TripMatchInitial());

  void createTripMatch(int tripRequestId) async {
    try {
      bool? isCreate = await repository.createTripMatch(tripRequestId);
      if (isCreate!) {
        emit(CreateTripMatchSuccess());
      } else {
        emit(CreateTripMatchFailure('Đã có lỗi xảy ra khi tạo chuyến'));
      }
    } catch (e) {
      emit(CreateTripMatchFailure(e.toString()));
    }
  }
}
