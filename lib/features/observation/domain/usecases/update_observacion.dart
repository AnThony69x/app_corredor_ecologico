import '../entities/observacion.dart';
import '../repositories/observation_repository.dart';

class UpdateObservacion {
  final ObservationRepository repository;
  UpdateObservacion(this.repository);

  Future<void> call(Observacion observacion) {
    return repository.updateObservacion(observacion);
  }
} 