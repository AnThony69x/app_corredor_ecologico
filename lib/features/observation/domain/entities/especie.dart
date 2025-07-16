class Especie {
  final String especieId;
  final String nombreCientifico;
  final String nombreComun;
  final String familia;
  final String estadoConservacion;
  final String? fotoUrl;
  final String? audioUrl;

  Especie({
    required this.especieId,
    required this.nombreCientifico,
    required this.nombreComun,
    required this.familia,
    required this.estadoConservacion,
    this.fotoUrl,
    this.audioUrl,
  });

  factory Especie.fromJson(Map<String, dynamic> json) => Especie(
        especieId: json['especie_id'] ?? '',
        nombreCientifico: json['nombre_cientifico'] ?? '',
        nombreComun: json['nombre_comun'] ?? '',
        familia: json['familia'] ?? '',
        estadoConservacion: json['estado_conservacion'] ?? '',
        fotoUrl: json['foto'],
        audioUrl: json['audio'],
      );
} 