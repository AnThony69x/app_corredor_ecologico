import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ObservationsMapScreen extends StatelessWidget {
  const ObservationsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Observaciones')),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-0.180653, -78.467834), // Ejemplo: Quito, Ecuador
          zoom: 12,
        ),
      ),
    );
  }
}
