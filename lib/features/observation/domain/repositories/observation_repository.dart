import '../entities/observacion.dart';

abstract class ObservationRepository {
  Future<List<Observacion>> getAllObservaciones(String participanteId);
  Future<Observacion?> getObservacion(String observationId);
  Future<void> createObservacion(Observacion observacion);
  Future<void> updateObservacion(Observacion observacion);
  Future<void> deleteObservacion(String observationId);
} 