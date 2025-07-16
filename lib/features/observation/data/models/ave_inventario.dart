class AveInventario {
  final String especieId;
  final String nombreComun;
  final String nombreCientifico;
  final String familia;
  final String fotoUrl;
  final String audioUrl;

  AveInventario({
    required this.especieId,
    required this.nombreComun,
    required this.nombreCientifico,
    required this.familia,
    required this.fotoUrl,
    required this.audioUrl,
  });

  factory AveInventario.fromJson(Map<String, dynamic> json) => AveInventario(
    especieId: json['especieId'],
    nombreComun: json['nombreComun'],
    nombreCientifico: json['nombreCientifico'],
    familia: json['familia'],
    fotoUrl: json['fotoUrl'],
    audioUrl: json['audioUrl'],
  );
} 