part of 'zone_bloc.dart';

@immutable
sealed class ZoneEvent {}

class GetAllZoneStarted extends ZoneEvent {}

class FilterZoneStarted extends ZoneEvent {
  final int fromZoneId;
  FilterZoneStarted({required this.fromZoneId});
}
