import 'package:flutter/material.dart';

class RecognitionResultScreen extends StatelessWidget {
  const RecognitionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultado = {
      'especie': 'Colibrí Andino',
      'confianza': '85%',
      'alternativas': [
        'Colibrí Andino',
        'Colibrí Esmeralda',
        'Colibrí Pico Espada',
      ],
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado de Reconocimiento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Especie Detectada: ${resultado['especie']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Confianza: ${resultado['confianza']}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Alternativas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...(resultado['alternativas'] as List<String>).map((alt) => ListTile(
              title: Text(alt),
              trailing: const Icon(Icons.radio_button_unchecked),
            )),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reconocimiento confirmado'),
                        ),
                      );
                    },
                    child: const Text('Confirmar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reconocimiento corregido'),
                        ),
                      );
                    },
                    child: const Text('Corregir'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
