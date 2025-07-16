import '../repositories/observation_repository.dart';

class DeleteObservacion {
  final ObservationRepository repository;
  DeleteObservacion(this.repository);

  Future<void> call(String observationId) {
    return repository.deleteObservacion(observationId);
  }
} 