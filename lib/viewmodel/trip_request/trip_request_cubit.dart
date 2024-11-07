import 'package:bloc/bloc.dart';
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
        emit(CreateTripRequestFailure('Failed to create trip request'));
      }
    } catch (e) {
      emit(CreateTripRequestFailure(e.toString()));
    }
  }
}
