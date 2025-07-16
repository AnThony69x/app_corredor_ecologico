import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../data/datasources/observation_remote_datasource.dart';
import '../../data/repositories/observation_repository_impl.dart';
import '../../domain/entities/observacion.dart';
import '../../domain/usecases/get_all_observaciones.dart';
import '../../domain/usecases/get_observacion.dart';
import '../../domain/usecases/create_observacion.dart';
import '../../domain/usecases/update_observacion.dart';
import '../../domain/usecases/delete_observacion.dart';

final supabaseClientProvider = Provider<supabase.SupabaseClient>((ref) => supabase.Supabase.instance.client);

final observationRemoteDataSourceProvider = Provider<ObservationRemoteDataSource>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return ObservationRemoteDataSourceImpl(client);
});

final observationRepositoryProvider = Provider<ObservationRepositoryImpl>((ref) {
  final remote = ref.watch(observationRemoteDataSourceProvider);
  return ObservationRepositoryImpl(remoteDataSource: remote);
});

final getAllObservacionesProvider = FutureProvider.family<List<Observacion>, String>((ref, participanteId) async {
  final repo = ref.watch(observationRepositoryProvider);
  final usecase = GetAllObservaciones(repo);
  return usecase(participanteId);
});

final getObservacionProvider = FutureProvider.family<Observacion?, String>((ref, observationId) async {
  final repo = ref.watch(observationRepositoryProvider);
  final usecase = GetObservacion(repo);
  return usecase(observationId);
});

final createObservacionProvider = FutureProvider.family<void, Observacion>((ref, observacion) async {
  final repo = ref.watch(observationRepositoryProvider);
  final usecase = CreateObservacion(repo);
  await usecase(observacion);
});

final updateObservacionProvider = FutureProvider.family<void, Observacion>((ref, observacion) async {
  final repo = ref.watch(observationRepositoryProvider);
  final usecase = UpdateObservacion(repo);
  await usecase(observacion);
});

final deleteObservacionProvider = FutureProvider.family<void, String>((ref, observationId) async {
  final repo = ref.watch(observationRepositoryProvider);
  final usecase = DeleteObservacion(repo);
  await usecase(observationId);
});

// Provider para el estado de la lista de observaciones
final observationListProvider = FutureProvider.autoDispose<void>((ref) async {
  // Aquí llamarías al caso de uso para obtener las observaciones
  // final observationRepository = ref.watch(observationRepositoryProvider);
  // return GetObservaciones(observationRepository).call('some_user_id');
});

// Provider para el estado del formulario de una nueva observación
// final observationFormProvider = StateNotifierProvider.autoDispose<void, void>((ref) {
//   // Lógica para manejar el estado del formulario de creación
//   return ref.watch(observationRepositoryProvider);
// }); 