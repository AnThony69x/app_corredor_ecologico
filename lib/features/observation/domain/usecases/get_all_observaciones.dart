import '../entities/observacion.dart';
import '../repositories/observation_repository.dart';

class GetAllObservaciones {
  final ObservationRepository repository;
  GetAllObservaciones(this.repository);

  Future<List<Observacion>> call(String participanteId) {
    return repository.getAllObservaciones(participanteId);
  }
} 