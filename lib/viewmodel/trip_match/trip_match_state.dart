part of 'trip_match_cubit.dart';

@immutable
sealed class TripMatchState {}

final class TripMatchInitial extends TripMatchState {}

final class CreateTripMatchSuccess extends TripMatchState {}

final class CreateTripMatchFailure extends TripMatchState {
  final String message;

  CreateTripMatchFailure(this.message);
}
