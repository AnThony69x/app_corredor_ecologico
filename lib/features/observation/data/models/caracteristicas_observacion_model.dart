import '../../domain/entities/caracteristicas_observacion.dart';

class CaracteristicasObservacionModel extends CaracteristicasObservacion {
  CaracteristicasObservacionModel({
    required super.featureId,
    required super.colorPredominante,
    required super.formaPico,
    required super.tamanoAve,
  });

  factory CaracteristicasObservacionModel.fromJson(Map<String, dynamic> json) {
    return CaracteristicasObservacionModel(
      featureId: json['feature_id'],
      colorPredominante: json['color_predominante'],
      formaPico: FormaPico.values.byName(json['forma_pico']),
      tamanoAve: TamanoAve.values.byName(json['tamano_ave']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feature_id': featureId,
      'color_predominante': colorPredominante,
      'forma_pico': formaPico.name,
      'tamano_ave': tamanoAve.name,
    };
  }
} 