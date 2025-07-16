import '../entities/observacion.dart';
import '../repositories/observation_repository.dart';

class GetObservacion {
  final ObservationRepository repository;
  GetObservacion(this.repository);

  Future<Observacion?> call(String observationId) {
    return repository.getObservacion(observationId);
  }
} 