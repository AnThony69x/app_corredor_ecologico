enum TipoArchivo { imagen, audio }

class ArchivoMultimedia {
  final String fileId;
  final TipoArchivo tipo;
  final String formato; // JPEG, PNG, MP3, WAV
  final int tamano; // en bytes
  final String rutaAlmacenamiento;

  ArchivoMultimedia({
    required this.fileId,
    required this.tipo,
    required this.formato,
    required this.tamano,
    required this.rutaAlmacenamiento,
  });
} 