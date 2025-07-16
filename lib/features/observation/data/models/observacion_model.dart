import '../../domain/entities/observacion.dart';
import 'archivo_multimedia_model.dart';
import 'caracteristicas_observacion_model.dart';
import 'especie_model.dart';
import 'resultado_reconocimiento_model.dart';

class ObservacionModel extends Observacion {
  ObservacionModel({
    required super.observationId,
    required super.fechaHora,
    super.notasAdicionales,
    required super.estado,
    required super.modoOffline,
    required super.participanteId,
    required super.resultadoReconocimiento,
    super.especieIdentificada,
    super.caracteristicas,
    required super.archivos,
  });

  factory ObservacionModel.fromJson(Map<String, dynamic> json) {
    return ObservacionModel(
      observationId: json['observation_id'],
      fechaHora: DateTime.parse(json['fecha_hora']),
      notasAdicionales: json['notas_adicionales'],
      estado: EstadoObservacion.values.byName(json['estado']),
      modoOffline: json['modo_offline'],
      participanteId: json['participante_id'],
      resultadoReconocimiento: ResultadoReconocimientoModel.fromJson(json['resultado_reconocimiento']),
      especieIdentificada: json['especie_identificada'] != null
          ? EspecieModel.fromJson(json['especie_identificada'])
          : null,
      caracteristicas: json['caracteristicas'] != null
          ? CaracteristicasObservacionModel.fromJson(json['caracteristicas'])
          : null,
      archivos: (json['archivos'] as List)
          .map((e) => ArchivoMultimediaModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'observation_id': observationId,
      'fecha_hora': fechaHora.toIso8601String(),
      'notas_adicionales': notasAdicionales,
      'estado': estado.name,
      'modo_offline': modoOffline,
      'participante_id': participanteId,
      'resultado_reconocimiento': (resultadoReconocimiento as ResultadoReconocimientoModel).toJson(),
      'especie_identificada': (especieIdentificada as EspecieModel?)?.toJson(),
      'caracteristicas': (caracteristicas as CaracteristicasObservacionModel?)?.toJson(),
      'archivos': archivos.map((e) => (e as ArchivoMultimediaModel).toJson()).toList(),
    };
  }

  static ObservacionModel fromEntity(Observacion entity) {
    return ObservacionModel(
      observationId: entity.observationId,
      fechaHora: entity.fechaHora,
      notasAdicionales: entity.notasAdicionales,
      estado: entity.estado,
      modoOffline: entity.modoOffline,
      participanteId: entity.participanteId,
      resultadoReconocimiento: entity.resultadoReconocimiento,
      especieIdentificada: entity.especieIdentificada,
      caracteristicas: entity.caracteristicas,
      archivos: entity.archivos,
    );
  }
} 