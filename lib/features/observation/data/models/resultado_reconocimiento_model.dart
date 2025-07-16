import '../../domain/entities/resultado_reconocimiento.dart';

class ResultadoReconocimientoModel extends ResultadoReconocimiento {
  ResultadoReconocimientoModel({
    required super.recognitionId,
    required super.porcentajeConfianza,
    required super.modeloUtilizado,
    required super.fechaProcesamiento,
    required super.confirmadoUsuario,
    required super.latitud,
    required super.longitud,
    required super.altitud,
    required super.precisionGps,
    required super.ajusteManual,
  });

  factory ResultadoReconocimientoModel.fromJson(Map<String, dynamic> json) {
    return ResultadoReconocimientoModel(
      recognitionId: json['recognition_id'],
      porcentajeConfianza: json['porcentaje_confianza'],
      modeloUtilizado: json['modelo_utilizado'],
      fechaProcesamiento: DateTime.parse(json['fecha_procesamiento']),
      confirmadoUsuario: json['confirmado_usuario'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      altitud: json['altitud'],
      precisionGps: json['precision_gps'],
      ajusteManual: json['ajuste_manual'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recognition_id': recognitionId,
      'porcentaje_confianza': porcentajeConfianza,
      'modelo_utilizado': modeloUtilizado,
      'fecha_procesamiento': fechaProcesamiento.toIso8601String(),
      'confirmado_usuario': confirmadoUsuario,
      'latitud': latitud,
      'longitud': longitud,
      'altitud': altitud,
      'precision_gps': precisionGps,
      'ajuste_manual': ajusteManual,
    };
  }
} 