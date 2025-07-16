import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/observacion_model.dart';

abstract class ObservationRemoteDataSource {
  Future<List<ObservacionModel>> getAllObservaciones(String participanteId);
  Future<ObservacionModel?> getObservacion(String observationId);
  Future<void> createObservacion(ObservacionModel observacion);
  Future<void> updateObservacion(ObservacionModel observacion);
  Future<void> deleteObservacion(String observationId);
}

class ObservationRemoteDataSourceImpl implements ObservationRemoteDataSource {
  final SupabaseClient client;
  ObservationRemoteDataSourceImpl(this.client);

  @override
  Future<List<ObservacionModel>> getAllObservaciones(String participanteId) async {
    final response = await client
        .from('observaciones')
        .select()
        .eq('participante_id', participanteId);
    return (response as List)
        .map((json) => ObservacionModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ObservacionModel?> getObservacion(String observationId) async {
    final response = await client
        .from('observaciones')
        .select()
        .eq('observation_id', observationId)
        .single();
    if (response == null) return null;
    return ObservacionModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<void> createObservacion(ObservacionModel observacion) async {
    await client.from('observaciones').insert(observacion.toJson());
  }

  @override
  Future<void> updateObservacion(ObservacionModel observacion) async {
    await client
        .from('observaciones')
        .update(observacion.toJson())
        .eq('observation_id', observacion.observationId);
  }

  @override
  Future<void> deleteObservacion(String observationId) async {
    await client
        .from('observaciones')
        .delete()
        .eq('observation_id', observationId);
  }
} 