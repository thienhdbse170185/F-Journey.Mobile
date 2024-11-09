import 'package:bloc/bloc.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:f_journey/model/repository/trip_request/trip_request_repository.dart';
import 'package:f_journey/model/request/trip_request/create_trip_request_request.dart';
import 'package:meta/meta.dart';

part 'trip_request_state.dart';

class TripRequestCubit extends Cubit<TripRequestState> {
  final TripRequestRepository repository;
  TripRequestCubit({required this.repository}) : super(TripRequestInitial());

  void createTripRequest(CreateTripRequestRequest request) async {
    emit(CreateTripRequestInProgress());
    try {
      bool? isCreate = await repository.createTripRequest(request);
      if (isCreate!) {
        emit(CreateTripRequestSuccess());
      } else {
        emit(CreateTripRequestFailure('Đã có lỗi xảy ra khi tạo chuyến'));
      }
    } catch (e) {
      emit(CreateTripRequestFailure(e.toString()));
    }
  }

  void getTripRequestByUserId(int userId) async {
    emit(GetTripRequestInProgress());
    try {
      List<TripRequestDto> tripRequests =
          await repository.getTripRequestByUserId(userId);
      tripRequests = tripRequests
          .where((tripRequest) => tripRequest.status == 'PENDING')
          .toList();
      emit(GetTripRequestSuccess(tripRequests));
    } catch (e) {
      emit(GetTripRequestFailure(e.toString()));
    }
  }

  void deleteTripRequest(int tripRequestId) async {
    try {
      bool? isDelete = await repository.deleteTripRequest(tripRequestId);
      if (isDelete!) {
        emit(DeleteTripRequestSuccess());
      } else {
        emit(DeleteTripRequestFailure('Đã có lỗi xảy ra khi xóa chuyến'));
      }
    } catch (e) {
      emit(DeleteTripRequestFailure(e.toString()));
    }
  }
}
