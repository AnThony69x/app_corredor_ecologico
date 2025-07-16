import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/observacion.dart';
import '../../domain/entities/archivo_multimedia.dart';
import '../../domain/entities/caracteristicas_observacion.dart';
import '../../domain/entities/resultado_reconocimiento.dart';
import '../../domain/entities/especie.dart';
import '../widgets/observation_card.dart';
import '../widgets/media_capture_widget.dart';
import '../widgets/characteristics_form_widget.dart';
import '../widgets/location_confirmation_widget.dart';
import '../widgets/recognition_result_widget.dart';

class ExampleUsageScreen extends ConsumerStatefulWidget {
  const ExampleUsageScreen({super.key});

  @override
  ConsumerState<ExampleUsageScreen> createState() => _ExampleUsageScreenState();
}

class _ExampleUsageScreenState extends ConsumerState<ExampleUsageScreen> {
  int _currentExample = 0;
  
  // Datos de ejemplo
  final List<Observacion> _exampleObservations = [
    Observacion(
      observationId: '1',
      fechaHora: DateTime.now().subtract(const Duration(hours: 2)),
      notasAdicionales: 'Observada en el parque central, muy activa',
      estado: EstadoObservacion.publicado,
      modoOffline: false,
      participanteId: 'user123',
      resultadoReconocimiento: ResultadoReconocimiento(
        recognitionId: 'rec1',
        porcentajeConfianza: 0.92,
        modeloUtilizado: 'IA Avanzada v2.1',
        fechaProcesamiento: DateTime.now(),
        confirmadoUsuario: false,
        latitud: 0.0,
        longitud: 0.0,
        altitud: 0.0,
        precisionGps: 0.0,
        ajusteManual: false,
      ),
      especieIdentificada: Especie(
        especieId: '1',
        nombreCientifico: 'Passer domesticus',
        nombreComun: 'Gorrión Común',
        familia: 'Passeridae',
        estadoConservacion: 'Preocupación Menor',
      ),
      caracteristicas: CaracteristicasObservacion(
        featureId: 'char1',
        colorPredominante: 'Marrón',
        formaPico: FormaPico.corto,
        tamanoAve: TamanoAve.pequeno,
      ),
      archivos: [
        ArchivoMultimedia(
          fileId: 'file1',
          tipo: TipoArchivo.imagen,
          formato: 'jpg',
          tamano: 1024000,
          rutaAlmacenamiento: '/temp/observation1.jpg',
        ),
      ],
    ),
    Observacion(
      observationId: '2',
      fechaHora: DateTime.now().subtract(const Duration(days: 1)),
      notasAdicionales: 'Hermosa ave con colores vibrantes',
      estado: EstadoObservacion.borrador,
      modoOffline: true,
      participanteId: 'user123',
      resultadoReconocimiento: ResultadoReconocimiento(
        recognitionId: 'rec2',
        porcentajeConfianza: 0.78,
        modeloUtilizado: 'IA Avanzada v2.1',
        fechaProcesamiento: DateTime.now(),
        confirmadoUsuario: false,
        latitud: 0.0,
        longitud: 0.0,
        altitud: 0.0,
        precisionGps: 0.0,
        ajusteManual: false,
      ),
      especieIdentificada: Especie(
        especieId: '2',
        nombreCientifico: 'Thraupis episcopus',
        nombreComun: 'Tangara Azuleja',
        familia: 'Thraupidae',
        estadoConservacion: 'Preocupación Menor',
      ),
      caracteristicas: CaracteristicasObservacion(
        featureId: 'char2',
        colorPredominante: 'Azul',
        formaPico: FormaPico.corto,
        tamanoAve: TamanoAve.mediano,
      ),
      archivos: [
        ArchivoMultimedia(
          fileId: 'file2',
          tipo: TipoArchivo.imagen,
          formato: 'jpg',
          tamano: 2048000,
          rutaAlmacenamiento: '/temp/observation2.jpg',
        ),
        ArchivoMultimedia(
          fileId: 'file3',
          tipo: TipoArchivo.audio,
          formato: 'mp3',
          tamano: 512000,
          rutaAlmacenamiento: '/temp/observation2_audio.mp3',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplos de Componentes'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Selector de ejemplos
          _buildExampleSelector(),
          
          // Contenido del ejemplo
          Expanded(
            child: _buildExampleContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecciona un componente para ver el ejemplo:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildExampleButton('Tarjeta de Observación', 0),
                const SizedBox(width: 8),
                _buildExampleButton('Captura de Media', 1),
                const SizedBox(width: 8),
                _buildExampleButton('Formulario de Características', 2),
                const SizedBox(width: 8),
                _buildExampleButton('Confirmación Geográfica', 3),
                const SizedBox(width: 8),
                _buildExampleButton('Resultado de Reconocimiento', 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleButton(String label, int index) {
    final isSelected = _currentExample == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentExample = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4CAF50) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4CAF50) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleContent() {
    switch (_currentExample) {
      case 0:
        return _buildObservationCardExample();
      case 1:
        return _buildMediaCaptureExample();
      case 2:
        return _buildCharacteristicsFormExample();
      case 3:
        return _buildLocationConfirmationExample();
      case 4:
        return _buildRecognitionResultExample();
      default:
        return const Center(child: Text('Selecciona un ejemplo'));
    }
  }

  Widget _buildObservationCardExample() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tarjetas de Observación',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _exampleObservations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ObservationCard(
                    observacion: _exampleObservations[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaCaptureExample() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Captura de Media',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: MediaCaptureWidget(
              archivos: [],
              onMediaCaptured: (archivos) {
                // Callback de ejemplo
                debugPrint('Archivos capturados: ${archivos.length}');
              },
              onNext: () {
                // Callback de ejemplo
                debugPrint('Siguiente paso');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacteristicsFormExample() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Formulario de Características',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: CharacteristicsFormWidget(
              caracteristicas: _exampleObservations.first.caracteristicas,
              onCharacteristicsChanged: (caracteristicas) {
                // Callback de ejemplo
                debugPrint('Características actualizadas: ${caracteristicas.tamanoAve}');
              },
              onNext: () {
                // Callback de ejemplo
                debugPrint('Siguiente paso');
              },
              onBack: () {
                // Callback de ejemplo
                debugPrint('Paso anterior');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationConfirmationExample() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confirmación Geográfica',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LocationConfirmationWidget(
              ubicacion: null,
              onLocationChanged: (position) {
                // Callback de ejemplo
                debugPrint('Ubicación actualizada: ${position.latitude}, ${position.longitude}');
              },
              onNext: () {
                // Callback de ejemplo
                debugPrint('Siguiente paso');
              },
              onBack: () {
                // Callback de ejemplo
                debugPrint('Paso anterior');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecognitionResultExample() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resultado de Reconocimiento',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RecognitionResultWidget(
              resultado: _exampleObservations.first.resultadoReconocimiento,
              especie: _exampleObservations.first.especieIdentificada,
              isProcessing: false,
              onSave: () {
                // Callback de ejemplo
                debugPrint('Observación guardada');
              },
              onBack: () {
                // Callback de ejemplo
                debugPrint('Paso anterior');
              },
            ),
          ),
        ],
      ),
    );
  }
} 