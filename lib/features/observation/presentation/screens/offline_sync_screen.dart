import 'package:flutter/material.dart';

class OfflineSyncScreen extends StatelessWidget {
  const OfflineSyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final observacionesPendientes = [
      'Observación 1 - Pendiente',
      'Observación 2 - Pendiente',
      'Observación 3 - Pendiente',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sincronización Offline')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: observacionesPendientes.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.cloud_off),
                title: Text(observacionesPendientes[index]),
                subtitle: const Text('Pendiente de sincronizar'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sincronizando...')),
                );
              },
              child: const Text('Sincronizar Todo'),
            ),
          ),
        ],
      ),
    );
  }
}
