enum FormaPico { ganchudo, corto, largo, desconocido }
enum TamanoAve { pequeno, mediano, grande, desconocido }

class CaracteristicasObservacion {
  final String featureId;
  final String colorPredominante;
  final FormaPico formaPico;
  final TamanoAve tamanoAve;

  CaracteristicasObservacion({
    required this.featureId,
    required this.colorPredominante,
    required this.formaPico,
    required this.tamanoAve,
  });
} 