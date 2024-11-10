part of 'reason_cubit.dart';

@immutable
sealed class ReasonState {}

final class ReasonInitial extends ReasonState {}

final class GetAllReasonInProgress extends ReasonState {}

final class GetAllReasonSuccess extends ReasonState {
  final List<ReasonDto> reasons;

  GetAllReasonSuccess({required this.reasons});
}

final class GetAllReasonFailure extends ReasonState {
  final String message;

  GetAllReasonFailure({required this.message});
}
