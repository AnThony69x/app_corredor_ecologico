import 'package:flutter/material.dart';
import '../../domain/entities/observacion.dart';

class ObservationCard extends StatelessWidget {
  final Observacion observacion;

  const ObservationCard({super.key, required this.observacion});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(observacion.especieIdentificada?.nombreComun ?? 'Especie no identificada'),
        subtitle: Text('Observado el: ${observacion.fechaHora.toLocal()}'),
        // Puedes agregar aquí más detalles si existen en tu modelo
      ),
    );
  }
} 