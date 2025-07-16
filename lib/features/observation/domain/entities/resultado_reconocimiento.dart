class ResultadoReconocimiento {
  final String recognitionId;
  final double porcentajeConfianza;
  final String modeloUtilizado;
  final DateTime fechaProcesamiento;
  final bool confirmadoUsuario;
  final double latitud;
  final double longitud;
  final double altitud;
  final double precisionGps;
  final bool ajusteManual;

  ResultadoReconocimiento({
    required this.recognitionId,
    required this.porcentajeConfianza,
    required this.modeloUtilizado,
    required this.fechaProcesamiento,
    required this.confirmadoUsuario,
    required this.latitud,
    required this.longitud,
    required this.altitud,
    required this.precisionGps,
    required this.ajusteManual,
  });
} 