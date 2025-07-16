import '../../domain/entities/especie.dart';

class EspecieModel extends Especie {
  EspecieModel({
    required super.especieId,
    required super.nombreCientifico,
    required super.nombreComun,
    required super.familia,
    required super.estadoConservacion,
  });

  factory EspecieModel.fromJson(Map<String, dynamic> json) {
    return EspecieModel(
      especieId: json['especie_id'],
      nombreCientifico: json['nombre_cientifico'],
      nombreComun: json['nombre_comun'],
      familia: json['familia'],
      estadoConservacion: json['estado_conservacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'especie_id': especieId,
      'nombre_cientifico': nombreCientifico,
      'nombre_comun': nombreComun,
      'familia': familia,
      'estado_conservacion': estadoConservacion,
    };
  }
} 