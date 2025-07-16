import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationConfirmationWidget extends StatefulWidget {
  final Position? ubicacion;
  final Function(Position) onLocationChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const LocationConfirmationWidget({
    super.key,
    this.ubicacion,
    required this.onLocationChanged,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<LocationConfirmationWidget> createState() => _LocationConfirmationWidgetState();
}

class _LocationConfirmationWidgetState extends State<LocationConfirmationWidget> {
  Position? _currentLocation;
  bool _isLoadingLocation = false;
  bool _hasLocationPermission = false;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    if (widget.ubicacion != null) {
      _currentLocation = widget.ubicacion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Título
          _buildHeader(),
          
          const SizedBox(height: 24),
          
          // Contenido principal
          Expanded(
            child: Row(
              children: [
                // Mapa (simulado)
                Expanded(
                  flex: 2,
                  child: _buildMapSection(),
                ),
                
                const SizedBox(width: 16),
                
                // Panel lateral
                Expanded(
                  flex: 1,
                  child: _buildSidePanel(),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Botones de navegación
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirmación Geográfica',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Confirma la ubicación exacta de tu observación',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          // Mapa simulado (aquí iría el widget de mapa real)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  const Color(0xFF81C784).withValues(alpha: 0.1),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 80,
                    color: const Color(0xFF4CAF50),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Mapa Interactivo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Aquí se mostraría el mapa con Leaflet/MapLibre',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          // Marcador de ubicación
          if (_currentLocation != null)
            Positioned(
              top: 50,
              left: 50,
              child: _buildLocationMarker(),
            ),
          
          // Controles del mapa
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                _buildMapControlButton(
                  icon: Icons.my_location,
                  onTap: _getCurrentLocation,
                ),
                const SizedBox(height: 8),
                _buildMapControlButton(
                  icon: Icons.zoom_in,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildMapControlButton(
                  icon: Icons.zoom_out,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMarker() {
    return GestureDetector(
      onPanUpdate: (details) {
        // Aquí se actualizaría la posición del marcador
        // En un mapa real, esto se manejaría con el SDK del mapa
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.location_on,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildMapControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            icon,
            color: const Color(0xFF4CAF50),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSidePanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título del panel
          const Text(
            'Información de Ubicación',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Precisión GPS
          _buildGpsAccuracyIndicator(),
          
          const SizedBox(height: 20),
          
          // Coordenadas
          if (_currentLocation != null) _buildCoordinatesInfo(),
          
          const SizedBox(height: 20),
          
          // Botón para usar ubicación actual
          _buildCurrentLocationButton(),
          
          const SizedBox(height: 20),
          
          // Notas adicionales
          _buildNotesField(),
          
          const Spacer(),
          
          // Información adicional
          _buildAdditionalInfo(),
        ],
      ),
    );
  }

  Widget _buildGpsAccuracyIndicator() {
    final accuracy = _currentLocation?.accuracy ?? 0.0;
    Color color;
    String status;
    IconData icon;

    if (accuracy < 5) {
      color = Colors.green;
      status = 'Excelente';
      icon = Icons.gps_fixed;
    } else if (accuracy < 15) {
      color = Colors.orange;
      status = 'Buena';
      icon = Icons.gps_not_fixed;
    } else {
      color = Colors.red;
      status = 'Baja';
      icon = Icons.gps_off;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Precisión GPS',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                if (accuracy > 0)
                  Text(
                    '±${accuracy.toStringAsFixed(1)}m',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoordinatesInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coordenadas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Lat: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                _currentLocation!.latitude.toStringAsFixed(6),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Lon: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                _currentLocation!.longitude.toStringAsFixed(6),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isLoadingLocation ? null : _getCurrentLocation,
        icon: _isLoadingLocation
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.my_location),
        label: Text(_isLoadingLocation ? 'Obteniendo...' : 'Usar mi ubicación'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notas de ubicación',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Descripción del lugar, puntos de referencia...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue[700],
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Puedes arrastrar el marcador en el mapa para ajustar la ubicación exacta',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        // Botón atrás
        Expanded(
          child: OutlinedButton(
            onPressed: widget.onBack,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFF4CAF50)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Atrás',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Botón siguiente
        Expanded(
          child: ElevatedButton(
            onPressed: _currentLocation != null ? widget.onNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: _currentLocation != null ? 4 : 0,
            ),
            child: const Text(
              'Siguiente',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showError('Los servicios de ubicación están deshabilitados');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showError('Se denegó el permiso de ubicación');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showError('Los permisos de ubicación están permanentemente denegados');
      return;
    }

    setState(() {
      _hasLocationPermission = true;
    });
  }

  Future<void> _getCurrentLocation() async {
    if (!_hasLocationPermission) {
      await _checkLocationPermission();
      if (!_hasLocationPermission) return;
    }

    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      setState(() {
        _currentLocation = position;
        _isLoadingLocation = false;
      });

      widget.onLocationChanged(position);
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
      _showError('Error al obtener la ubicación: $e');
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