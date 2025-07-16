import '../../domain/entities/archivo_multimedia.dart';

class ArchivoMultimediaModel extends ArchivoMultimedia {
  ArchivoMultimediaModel({
    required super.fileId,
    required super.tipo,
    required super.formato,
    required super.tamano,
    required super.rutaAlmacenamiento,
  });

  factory ArchivoMultimediaModel.fromJson(Map<String, dynamic> json) {
    return ArchivoMultimediaModel(
      fileId: json['file_id'],
      tipo: TipoArchivo.values.byName(json['tipo']),
      formato: json['formato'],
      tamano: json['tamano'],
      rutaAlmacenamiento: json['ruta_almacenamiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_id': fileId,
      'tipo': tipo.name,
      'formato': formato,
      'tamano': tamano,
      'ruta_almacenamiento': rutaAlmacenamiento,
    };
  }
} 