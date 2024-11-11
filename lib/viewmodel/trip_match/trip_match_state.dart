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
  final List<TripMatchDto> pendingTripMatches;
  final List<TripMatchDto> acceptedTripMatches;
  final List<TripMatchDto> canceledTripMatches;
  final List<TripMatchDto> completedTripMatches;
  final List<TripMatchDto> inProgressTripMatches;
  final List<TripMatchDto> rejectedTripMatches;

  GetTripMatchByDriverIdSuccess(
      this.pendingTripMatches,
      this.acceptedTripMatches,
      this.canceledTripMatches,
      this.completedTripMatches,
      this.inProgressTripMatches,
      this.rejectedTripMatches);
}

final class GetTripMatchByDriverIdFailure extends TripMatchState {
  final String message;

  GetTripMatchByDriverIdFailure(this.message);
}

final class GetTripMatchByPassengerIdSuccess extends TripMatchState {
  final List<TripMatchDto> pendingTripMatches;
  final List<TripMatchDto> acceptedTripMatches;
  final List<TripMatchDto> canceledTripMatches;
  final List<TripMatchDto> completedTripMatches;
  final List<TripMatchDto> inProgressTripMatches;
  final List<TripMatchDto> rejectedTripMatches;

  GetTripMatchByPassengerIdSuccess(
      this.pendingTripMatches,
      this.acceptedTripMatches,
      this.canceledTripMatches,
      this.completedTripMatches,
      this.inProgressTripMatches,
      this.rejectedTripMatches);
}

final class GetTripMatchByPassengerIdFailure extends TripMatchState {
  final String message;

  GetTripMatchByPassengerIdFailure(this.message);
}

final class UpdateTripMatchStatusInProgress extends TripMatchState {}

final class UpdateTripMatchStatusSuccess extends TripMatchState {}

final class UpdateTripMatchStatusFailure extends TripMatchState {
  final String message;

  UpdateTripMatchStatusFailure(this.message);
}

final class GetTripMatchByPassengerIdInProgress extends TripMatchState {}

final class GetTripMatchByDriverIdInProgress extends TripMatchState {}
