import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/archivo_multimedia.dart';

class MediaCaptureWidget extends StatefulWidget {
  final List<ArchivoMultimedia> archivos;
  final Function(List<ArchivoMultimedia>) onMediaCaptured;
  final VoidCallback onNext;

  const MediaCaptureWidget({
    super.key,
    required this.archivos,
    required this.onMediaCaptured,
    required this.onNext,
  });

  @override
  State<MediaCaptureWidget> createState() => _MediaCaptureWidgetState();
}

class _MediaCaptureWidgetState extends State<MediaCaptureWidget> {
  final ImagePicker _picker = ImagePicker();
  bool _isRecording = false;
  int _recordingTime = 0;
  TipoArchivo _currentMode = TipoArchivo.imagen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Título y descripción
          _buildHeader(),
          
          const SizedBox(height: 24),
          
          // Área de captura
          Expanded(
            child: _buildCaptureArea(),
          ),
          
          const SizedBox(height: 24),
          
          // Controles de captura
          _buildCaptureControls(),
          
          const SizedBox(height: 16),
          
          // Lista de archivos capturados
          if (widget.archivos.isNotEmpty) _buildMediaList(),
          
          const SizedBox(height: 16),
          
          // Botón siguiente
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'Captura de Media',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Toma una foto o graba audio de la ave que observaste',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCaptureArea() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          // Área de vista previa
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _currentMode == TipoArchivo.imagen
                      ? Icons.camera_alt
                      : Icons.mic,
                  size: 80,
                  color: const Color(0xFF4CAF50),
                ),
                const SizedBox(height: 16),
                Text(
                  _currentMode == TipoArchivo.imagen
                      ? 'Toca para tomar una foto'
                      : 'Toca para grabar audio',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                if (_currentMode == TipoArchivo.audio)
                  Text(
                    'Máximo 30 segundos',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          
          // Overlay de cuadrícula (solo para imagen)
          if (_currentMode == TipoArchivo.imagen)
            _buildGridOverlay(),
          
          // Indicador de calidad
          Positioned(
            top: 16,
            right: 16,
            child: _buildQualityIndicator(),
          ),
          
          // Tiempo de grabación
          if (_isRecording)
            Positioned(
              top: 16,
              left: 16,
              child: _buildRecordingTimer(),
            ),
        ],
      ),
    );
  }

  Widget _buildGridOverlay() {
    return CustomPaint(
      size: Size.infinite,
      painter: GridPainter(),
    );
  }

  Widget _buildQualityIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wb_sunny,
            size: 16,
            color: Colors.yellow[300],
          ),
          const SizedBox(width: 4),
          const Text(
            'Buena iluminación',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingTimer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${_recordingTime}s',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptureControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Botón cámara
        _buildModeButton(
          icon: Icons.camera_alt,
          label: 'Foto',
          isActive: _currentMode == TipoArchivo.imagen,
          onTap: () => _setMode(TipoArchivo.imagen),
        ),
        
        // Botón de captura principal
        GestureDetector(
          onTap: _captureMedia,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _isRecording ? Colors.red : const Color(0xFF4CAF50),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (_isRecording ? Colors.red : const Color(0xFF4CAF50)).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              _isRecording ? Icons.stop : Icons.camera_alt,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        
        // Botón micrófono
        _buildModeButton(
          icon: Icons.mic,
          label: 'Audio',
          isActive: _currentMode == TipoArchivo.audio,
          onTap: () => _setMode(TipoArchivo.audio),
        ),
      ],
    );
  }

  Widget _buildModeButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF4CAF50).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF4CAF50) : Colors.grey[300]!,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF4CAF50) : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? const Color(0xFF4CAF50) : Colors.grey[600],
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.archivos.length,
        itemBuilder: (context, index) {
          final archivo = widget.archivos[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    archivo.tipo == TipoArchivo.imagen
                        ? Icons.image
                        : archivo.tipo == TipoArchivo.audio
                            ? Icons.audiotrack
                            : Icons.videocam,
                    size: 32,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _removeMedia(index),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNextButton() {
    final canProceed = widget.archivos.isNotEmpty;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canProceed ? widget.onNext : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: canProceed ? 4 : 0,
        ),
        child: const Text(
          'Siguiente',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _setMode(TipoArchivo mode) {
    setState(() {
      _currentMode = mode;
    });
  }

  Future<void> _captureMedia() async {
    if (_currentMode == TipoArchivo.imagen) {
      await _captureImage();
    } else {
      await _captureAudio();
    }
  }

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final archivo = ArchivoMultimedia(
          fileId: DateTime.now().millisecondsSinceEpoch.toString(),
          tipo: TipoArchivo.imagen,
          formato: 'jpg',
          tamano: await image.length(),
          rutaAlmacenamiento: image.path,
        );

        final newArchivos = List<ArchivoMultimedia>.from(widget.archivos)
          ..add(archivo);
        widget.onMediaCaptured(newArchivos);
      }
    } catch (e) {
      _showError('Error al capturar imagen: $e');
    }
  }

  Future<void> _captureAudio() async {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordingTime = 0;
    });

    // Simular grabación
    Future.delayed(const Duration(seconds: 1), () {
      if (_isRecording && _recordingTime < 30) {
        setState(() {
          _recordingTime++;
        });
        _startRecording();
      } else if (_recordingTime >= 30) {
        _stopRecording();
      }
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });

    // Simular archivo de audio
    final archivo = ArchivoMultimedia(
      fileId: DateTime.now().millisecondsSinceEpoch.toString(),
      tipo: TipoArchivo.audio,
      formato: 'mp3',
      tamano: _recordingTime * 16000, // Simular tamaño
      rutaAlmacenamiento: '/temp/audio_${DateTime.now().millisecondsSinceEpoch}.mp3',
    );

    final newArchivos = List<ArchivoMultimedia>.from(widget.archivos)
      ..add(archivo);
    widget.onMediaCaptured(newArchivos);
  }

  void _removeMedia(int index) {
    final newArchivos = List<ArchivoMultimedia>.from(widget.archivos)
      ..removeAt(index);
    widget.onMediaCaptured(newArchivos);
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

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    // Líneas verticales
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(size.width * i / 3, 0),
        Offset(size.width * i / 3, size.height),
        paint,
      );
    }

    // Líneas horizontales
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(0, size.height * i / 3),
        Offset(size.width, size.height * i / 3),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 