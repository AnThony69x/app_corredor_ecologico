import '../../domain/entities/observacion.dart';
import '../../domain/repositories/observation_repository.dart';
import '../datasources/observation_remote_datasource.dart';
import '../models/observacion_model.dart';

class ObservationRepositoryImpl implements ObservationRepository {
  final ObservationRemoteDataSource remoteDataSource;
  // final Connectivity connectivity; // Para manejar offline

  ObservationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> createObservacion(Observacion observacion) {
    return remoteDataSource.createObservacion(ObservacionModel.fromEntity(observacion));
  }

  @override
  Future<void> deleteObservacion(String observationId) {
    return remoteDataSource.deleteObservacion(observationId);
  }

  @override
  Future<List<Observacion>> getAllObservaciones(String participanteId) {
    return remoteDataSource.getAllObservaciones(participanteId);
  }

  @override
  Future<Observacion?> getObservacion(String observationId) {
    return remoteDataSource.getObservacion(observationId);
  }

  @override
  Future<void> updateObservacion(Observacion observacion) {
    return remoteDataSource.updateObservacion(ObservacionModel.fromEntity(observacion));
  }
} 