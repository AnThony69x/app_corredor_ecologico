import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/observation_providers.dart';
import '../widgets/observation_card.dart';
import 'observation_form_screen.dart';
import 'observation_detail_screen.dart';

class ObservationListScreen extends ConsumerStatefulWidget {
  final String? participanteId;
  const ObservationListScreen({super.key, this.participanteId});

  @override
  ConsumerState<ObservationListScreen> createState() => _ObservationListScreenState();
}

class _ObservationListScreenState extends ConsumerState<ObservationListScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _participanteId;
  bool _autoLoaded = false;

  @override
  void initState() {
    super.initState();
    // Si se pasa por parámetro, usarlo
    if (widget.participanteId != null) {
      _participanteId = widget.participanteId;
      _controller.text = widget.participanteId!;
    }
  }

  void _loadFromAuth() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null && !_autoLoaded) {
      setState(() {
        _participanteId = user.id;
        _controller.text = user.id;
        _autoLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadFromAuth();
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Observaciones')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'ID de Participante',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              onSubmitted: (value) {
                setState(() {
                  _participanteId = value.trim();
                });
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _participanteId = _controller.text.trim();
                });
              },
              child: const Text('Ver Observaciones'),
            ),
            const SizedBox(height: 16),
            if (_participanteId == null || _participanteId!.isEmpty)
              const Text('Por favor ingresa un ID de participante o inicia sesión.', style: TextStyle(color: Colors.grey)),
            if (_participanteId != null && _participanteId!.isNotEmpty)
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) {
                    final observacionesAsync = ref.watch(getAllObservacionesProvider(_participanteId!));
                    return observacionesAsync.when(
                      data: (observaciones) => observaciones.isEmpty
                          ? const Center(child: Text('No hay observaciones para este participante.'))
                          : ListView.builder(
                              itemCount: observaciones.length,
                              itemBuilder: (context, index) {
                                final obs = observaciones[index];
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ObservationDetailScreen(observacionId: obs.observationId),
                                    ),
                                  ),
                                  child: ObservationCard(observacion: obs),
                                );
                              },
                            ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Error: $e')),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: (_participanteId != null && _participanteId!.isNotEmpty)
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ObservationFormScreen(participanteId: _participanteId!),
                ),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
} 