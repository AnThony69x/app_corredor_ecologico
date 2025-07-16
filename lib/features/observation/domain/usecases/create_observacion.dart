import '../entities/observacion.dart';
import '../repositories/observation_repository.dart';

class CreateObservacion {
  final ObservationRepository repository;

  CreateObservacion(this.repository);

  Future<void> call(Observacion observacion) {
    return repository.createObservacion(observacion);
  }
} 