import 'package:bloc/bloc.dart';
import 'package:f_journey/model/dto/zone_dto.dart';
import 'package:f_journey/model/repository/zone/zone_repository.dart';
import 'package:meta/meta.dart';

part 'zone_event.dart';
part 'zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  final ZoneRepository zoneRepository;
  ZoneBloc({required this.zoneRepository}) : super(ZoneInitial()) {
    on<GetAllZoneStarted>((event, emit) => _onGetAllZone(event, emit));
    on<FilterZoneStarted>((event, emit) => _onFilterZone(event, emit));
  }

  Future<void> _onGetAllZone(
      GetAllZoneStarted event, Emitter<ZoneState> emit) async {
    emit(GetAllZoneInProgress());
    try {
      final zones = await zoneRepository.getAllZone();
      emit(GetAllZoneSuccess(zones.result.data));
    } catch (e) {
      emit(GetAllZoneFailure('Failed to get all zone'));
      rethrow;
    }
  }

  Future<void> _onFilterZone(
      FilterZoneStarted event, Emitter<ZoneState> emit) async {
    try {
      final zones = await zoneRepository.filterZone(event.fromZoneId);
      emit(FilterZoneSuccess(zones));
    } catch (e) {
      emit(FilterZoneFailure('Failed to filter zone'));
      rethrow;
    }
  }
}
