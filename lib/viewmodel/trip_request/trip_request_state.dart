part of 'trip_request_cubit.dart';

@immutable
sealed class TripRequestState {}

final class TripRequestInitial extends TripRequestState {}

final class CreateTripRequestInProgress extends TripRequestState {}

final class CreateTripRequestSuccess extends TripRequestState {}

final class CreateTripRequestFailure extends TripRequestState {
  final String message;

  CreateTripRequestFailure(this.message);
}

final class GetTripRequestInProgress extends TripRequestState {}

final class GetTripRequestSuccess extends TripRequestState {
  final List<TripRequestDto> tripRequests;

  GetTripRequestSuccess(this.tripRequests);
}

final class GetTripRequestFailure extends TripRequestState {
  final String message;

  GetTripRequestFailure(this.message);
}

final class DeleteTripRequestSuccess extends TripRequestState {}

final class DeleteTripRequestFailure extends TripRequestState {
  final String message;

  DeleteTripRequestFailure(this.message);
}
