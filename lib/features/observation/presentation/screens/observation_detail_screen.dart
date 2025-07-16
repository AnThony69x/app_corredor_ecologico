import 'package:flutter/material.dart';

class ObservationDetailScreen extends StatelessWidget {
  final String? observacionId;
  const ObservationDetailScreen({super.key, this.observacionId});

  @override
  Widget build(BuildContext context) {
    // Datos simulados
    final observacion = {
      'id': observacionId ?? 'Sin ID',
      'especie': 'Ave Ejemplo',
      'fecha': '2024-05-01',
      'ubicacion': 'Quito, Ecuador',
      'descripcion': 'Observación de un ave en el parque.',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Observación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${observacion['id']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Especie: ${observacion['especie']}'),
            Text('Fecha: ${observacion['fecha']}'),
            Text('Ubicación: ${observacion['ubicacion']}'),
            const SizedBox(height: 10),
            Text(
              'Descripción:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(observacion['descripcion']!),
          ],
        ),
      ),
    );
  }
}
