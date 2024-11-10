import 'package:bloc/bloc.dart';
import 'package:f_journey/model/dto/trip_match_dto.dart';
import 'package:f_journey/model/repository/trip_match/trip_match_repository.dart';
import 'package:f_journey/model/response/trip_match/get_trip_match_by_user_id_response.dart';
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

  void getTripMatchByDriverId(int userId) async {
    try {
      GetTripMatchByUserIdResult tripMatches =
          await repository.getTripMatchByDriverId(userId);
      emit(GetTripMatchByDriverIdSuccess(tripMatches.data));
    } catch (e) {
      emit(GetTripMatchByDriverIdFailure(e.toString()));
    }
  }

  void getTripMatchByPassengerId(int passengerId) async {
    emit(GetTripMatchByPassengerIdInProgress());
    try {
      GetTripMatchByUserIdResult tripMatches =
          await repository.getAllTripMatch();
      List<TripMatchDto> pendingTripMatches = tripMatches.data
          .where((element) =>
              element.status == 'Pending' &&
              element.tripRequest.userId == passengerId)
          .toList();
      List<TripMatchDto> acceptedTripMatches = tripMatches.data
          .where((element) =>
              element.status == 'Accepted' &&
              element.tripRequest.userId == passengerId)
          .toList();
      List<TripMatchDto> canceledTripMatches = tripMatches.data
          .where((element) =>
              element.status == 'Canceled' &&
              element.tripRequest.userId == passengerId)
          .toList();
      List<TripMatchDto> completedTripMatches = tripMatches.data
          .where((element) =>
              element.status == 'Completed' &&
              element.tripRequest.userId == passengerId)
          .toList();
      List<TripMatchDto> inProgressTripMatches = tripMatches.data
          .where((element) =>
              element.status == 'InProgress' &&
              element.tripRequest.userId == passengerId)
          .toList();
      List<TripMatchDto> rejectedTripMatches = tripMatches.data
          .where((element) =>
              element.status == 'Rejected' &&
              element.tripRequest.userId == passengerId)
          .toList();

      emit(GetTripMatchByPassengerIdSuccess(
          pendingTripMatches,
          acceptedTripMatches,
          canceledTripMatches,
          completedTripMatches,
          inProgressTripMatches,
          rejectedTripMatches));
    } catch (e) {
      emit(GetTripMatchByPassengerIdFailure(e.toString()));
    }
  }

  void updateTripMatchStatus(int tripMatchId, String status, int? reasonId,
      bool isTripMatchUpdate) async {
    emit(UpdateTripMatchStatusInProgress());
    try {
      bool isUpdate = await repository.updateTripMatchStatus(
          tripMatchId, status, reasonId, isTripMatchUpdate);
      if (isUpdate) {
        emit(UpdateTripMatchStatusSuccess());
      } else {
        emit(UpdateTripMatchStatusFailure('Đã có lỗi xảy ra khi cập nhật'));
      }
    } catch (e) {
      emit(UpdateTripMatchStatusFailure(e.toString()));
    }
  }
}
