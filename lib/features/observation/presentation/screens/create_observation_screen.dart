import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/entities/observacion.dart';
import '../../domain/entities/archivo_multimedia.dart';
import '../../domain/entities/caracteristicas_observacion.dart';
import '../../domain/entities/resultado_reconocimiento.dart';
import '../../domain/entities/especie.dart';
import '../providers/observation_providers.dart';
import '../widgets/media_capture_widget.dart';
import '../widgets/characteristics_form_widget.dart';
import '../widgets/location_confirmation_widget.dart';
import '../widgets/recognition_result_widget.dart';

class CreateObservationScreen extends ConsumerStatefulWidget {
  final String participanteId;
  
  const CreateObservationScreen({
    super.key,
    required this.participanteId,
  });

  @override
  ConsumerState<CreateObservationScreen> createState() => _CreateObservationScreenState();
}

class _CreateObservationScreenState extends ConsumerState<CreateObservationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  // Datos de la observación
  List<ArchivoMultimedia> _archivos = [];
  CaracteristicasObservacion? _caracteristicas;
  Position? _ubicacion;
  ResultadoReconocimiento? _resultadoReconocimiento;
  Especie? _especieIdentificada;
  final String _notasAdicionales = '';
  final bool _modoOffline = false;
  
  // Estados de carga
  bool _isProcessingRecognition = false;

  final List<String> _stepTitles = [
    'Captura de Media',
    'Características',
    'Ubicación',
    'Resultado',
  ];

  final List<IconData> _stepIcons = [
    Icons.camera_alt,
    Icons.description,
    Icons.location_on,
    Icons.auto_awesome,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Nueva Observación'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _saveDraft,
              child: const Text(
                'Guardar Borrador',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Indicador de progreso
          _buildProgressIndicator(),
          
          // Contenido principal
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                // Paso 1: Captura de Media
                MediaCaptureWidget(
                  archivos: _archivos,
                  onMediaCaptured: _onMediaCaptured,
                  onNext: _nextStep,
                ),
                
                // Paso 2: Formulario de Características
                CharacteristicsFormWidget(
                  caracteristicas: _caracteristicas,
                  onCharacteristicsChanged: _onCharacteristicsChanged,
                  onNext: _nextStep,
                  onBack: _previousStep,
                ),
                
                // Paso 3: Confirmación Geográfica
                LocationConfirmationWidget(
                  ubicacion: _ubicacion,
                  onLocationChanged: _onLocationChanged,
                  onNext: _processRecognition,
                  onBack: _previousStep,
                ),
                
                // Paso 4: Resultado de Reconocimiento
                RecognitionResultWidget(
                  resultado: _resultadoReconocimiento,
                  especie: _especieIdentificada,
                  isProcessing: _isProcessingRecognition,
                  onSave: _saveObservation,
                  onBack: _previousStep,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
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
        children: [
          // Barra de progreso
          LinearProgressIndicator(
            value: (_currentStep + 1) / _stepTitles.length,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
          ),
          
          const SizedBox(height: 16),
          
          // Pasos
          Row(
            children: List.generate(_stepTitles.length, (index) {
              final isActive = index == _currentStep;
              final isCompleted = index < _currentStep;
              
              return Expanded(
                child: Row(
                  children: [
                    // Icono del paso
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFF4CAF50)
                            : isActive
                                ? const Color(0xFF4CAF50).withValues(alpha: 0.2)
                                : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _stepIcons[index],
                        color: isCompleted || isActive
                            ? const Color(0xFF4CAF50)
                            : Colors.grey[600],
                        size: 20,
                      ),
                    ),
                    
                    // Línea conectora
                    if (index < _stepTitles.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted
                              ? const Color(0xFF4CAF50)
                              : Colors.grey[300],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          
          const SizedBox(height: 8),
          
          // Títulos de los pasos
          Row(
            children: List.generate(_stepTitles.length, (index) {
              final isActive = index == _currentStep;
              final isCompleted = index < _currentStep;
              
              return Expanded(
                child: Text(
                  _stepTitles[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive || isCompleted
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isActive || isCompleted
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _onMediaCaptured(List<ArchivoMultimedia> archivos) {
    setState(() {
      _archivos = archivos;
    });
  }

  void _onCharacteristicsChanged(CaracteristicasObservacion caracteristicas) {
    setState(() {
      _caracteristicas = caracteristicas;
    });
  }

  void _onLocationChanged(Position ubicacion) {
    setState(() {
      _ubicacion = ubicacion;
    });
  }

  void _nextStep() {
    if (_currentStep < _stepTitles.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _processRecognition() async {
    if (_archivos.isEmpty) {
      _showError('Debes capturar al menos una imagen o audio');
      return;
    }

    setState(() {
      _isProcessingRecognition = true;
    });

    try {
      // Simular procesamiento de reconocimiento
      await Future.delayed(const Duration(seconds: 3));
      
      // Aquí iría la lógica real de reconocimiento
      final resultado = ResultadoReconocimiento(
        recognitionId: DateTime.now().millisecondsSinceEpoch.toString(),
        porcentajeConfianza: 0.85,
        modeloUtilizado: 'IA Avanzada v2.1',
        fechaProcesamiento: DateTime.now(),
        confirmadoUsuario: false,
        latitud: _ubicacion?.latitude ?? 0.0,
        longitud: _ubicacion?.longitude ?? 0.0,
        altitud: _ubicacion?.altitude ?? 0.0,
        precisionGps: _ubicacion?.accuracy ?? 0.0,
        ajusteManual: false,
      );

      final especie = Especie(
        especieId: '1',
        nombreCientifico: 'Passer domesticus',
        nombreComun: 'Gorrión Común',
        familia: 'Passeridae',
        estadoConservacion: 'Preocupación Menor',
      );

      setState(() {
        _resultadoReconocimiento = resultado;
        _especieIdentificada = especie;
        _isProcessingRecognition = false;
      });

      _nextStep();
    } catch (e) {
      setState(() {
        _isProcessingRecognition = false;
      });
      _showError('Error en el reconocimiento: $e');
    }
  }

  Future<void> _saveObservation() async {
    if (_resultadoReconocimiento == null) {
      _showError('Debes completar el reconocimiento');
      return;
    }

    try {
      final observacion = Observacion(
        observationId: DateTime.now().millisecondsSinceEpoch.toString(),
        fechaHora: DateTime.now(),
        notasAdicionales: _notasAdicionales,
        estado: EstadoObservacion.borrador,
        modoOffline: _modoOffline,
        participanteId: widget.participanteId,
        resultadoReconocimiento: _resultadoReconocimiento!,
        especieIdentificada: _especieIdentificada,
        caracteristicas: _caracteristicas,
        archivos: _archivos,
      );

      await ref.read(createObservacionProvider(observacion).future);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Observación guardada exitosamente'),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
      }
    } catch (e) {
      _showError('Error al guardar la observación: $e');
    }
  }

  Future<void> _saveDraft() async {
    setState(() {
      _isProcessingRecognition = true;
    });

    try {
      final observacion = Observacion(
        observationId: DateTime.now().millisecondsSinceEpoch.toString(),
        fechaHora: DateTime.now(),
        notasAdicionales: _notasAdicionales,
        estado: EstadoObservacion.borrador,
        modoOffline: _modoOffline,
        participanteId: widget.participanteId,
        resultadoReconocimiento: _resultadoReconocimiento!,
        especieIdentificada: _especieIdentificada,
        caracteristicas: _caracteristicas,
        archivos: _archivos,
      );

      await ref.read(createObservacionProvider(observacion).future);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Borrador guardado'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      _showError('Error al guardar el borrador: $e');
    } finally {
      setState(() {
        _isProcessingRecognition = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
} 