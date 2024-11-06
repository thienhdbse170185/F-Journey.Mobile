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
