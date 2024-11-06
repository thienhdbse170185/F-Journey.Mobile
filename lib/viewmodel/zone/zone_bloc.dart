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
  }

  Future<void> _onGetAllZone(
      GetAllZoneStarted event, Emitter<ZoneState> emit) async {
    emit(GetAllZoneInProgress());
    try {
      final zones = await zoneRepository.getAllZone();
      emit(GetAllZoneSuccess(zones));
    } catch (e) {
      emit(GetAllZoneFailure('Failed to get all zone'));
      rethrow;
    }
  }
}
