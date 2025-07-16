import 'archivo_multimedia.dart';
import 'caracteristicas_observacion.dart';
import 'especie.dart';
import 'resultado_reconocimiento.dart';

enum EstadoObservacion { borrador, publicado, privado }

class Observacion {
  final String observationId;
  final DateTime fechaHora;
  final String? notasAdicionales;
  final EstadoObservacion estado;
  final bool modoOffline;

  // Relationships
  final String participanteId; 
  final ResultadoReconocimiento resultadoReconocimiento; 
  final Especie? especieIdentificada; 
  final CaracteristicasObservacion? caracteristicas; 
  final List<ArchivoMultimedia> archivos; 

  Observacion({
    required this.observationId,
    required this.fechaHora,
    this.notasAdicionales,
    required this.estado,
    required this.modoOffline,
    required this.participanteId,
    required this.resultadoReconocimiento,
    this.especieIdentificada,
    this.caracteristicas,
    required this.archivos,
  });

  factory Observacion.simple({
    required String especieId,
    required String fotoPath,
    String? audioPath,
    required DateTime fecha,
  }) {
    return Observacion(
      observationId: DateTime.now().millisecondsSinceEpoch.toString(),
      fechaHora: fecha,
      notasAdicionales: null,
      estado: EstadoObservacion.borrador,
      modoOffline: true,
      participanteId: '',
      resultadoReconocimiento: ResultadoReconocimiento(
        recognitionId: '',
        porcentajeConfianza: 0.0,
        modeloUtilizado: '',
        fechaProcesamiento: fecha,
        confirmadoUsuario: false,
        latitud: 0.0,
        longitud: 0.0,
        altitud: 0.0,
        precisionGps: 0.0,
        ajusteManual: false,
      ),
      especieIdentificada: Especie(
        especieId: especieId,
        nombreCientifico: '',
        nombreComun: '',
        familia: '',
        estadoConservacion: '',
      ),
      caracteristicas: null,
      archivos: [],
    );
  }
} 