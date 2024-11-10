part of 'trip_match_cubit.dart';

@immutable
sealed class TripMatchState {}

final class TripMatchInitial extends TripMatchState {}

final class CreateTripMatchSuccess extends TripMatchState {}

final class CreateTripMatchFailure extends TripMatchState {
  final String message;

  CreateTripMatchFailure(this.message);
}

final class GetTripMatchByDriverIdSuccess extends TripMatchState {
  final List<TripMatchDto> tripMatches;

  GetTripMatchByDriverIdSuccess(this.tripMatches);
}

final class GetTripMatchByDriverIdFailure extends TripMatchState {
  final String message;

  GetTripMatchByDriverIdFailure(this.message);
}

final class GetTripMatchByPassengerIdSuccess extends TripMatchState {
  final List<TripMatchDto> tripMatches;

  GetTripMatchByPassengerIdSuccess(this.tripMatches);
}

final class GetTripMatchByPassengerIdFailure extends TripMatchState {
  final String message;

  GetTripMatchByPassengerIdFailure(this.message);
}

final class UpdateTripMatchStatusSuccess extends TripMatchState {}

final class UpdateTripMatchStatusFailure extends TripMatchState {
  final String message;

  UpdateTripMatchStatusFailure(this.message);
}
