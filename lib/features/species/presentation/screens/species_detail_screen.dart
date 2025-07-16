import 'package:flutter/material.dart';
import '../../../observation/data/models/especie_model.dart';

class SpeciesDetailScreen extends StatelessWidget {
  final EspecieModel especie;
  const SpeciesDetailScreen({super.key, required this.especie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(especie.nombreComun)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre científico: ${especie.nombreCientifico}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('Familia: ${especie.familia}'),
            const SizedBox(height: 8),
            Text('Estado de conservación: ${especie.estadoConservacion}'),
            // Puedes agregar imagen/audio aquí si tienes los datos
          ],
        ),
      ),
    );
  }
}
