import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/observacion.dart';
import '../providers/observation_providers.dart';

class ObservationFormScreen extends ConsumerStatefulWidget {
  final String participanteId;
  final Observacion? initial;
  const ObservationFormScreen({super.key, required this.participanteId, this.initial});

  @override
  ConsumerState<ObservationFormScreen> createState() => _ObservationFormScreenState();
}

class _ObservationFormScreenState extends ConsumerState<ObservationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _notasController;
  bool _modoOffline = false;

  @override
  void initState() {
    super.initState();
    _notasController = TextEditingController(text: widget.initial?.notasAdicionales ?? '');
    _modoOffline = widget.initial?.modoOffline ?? false;
  }

  @override
  void dispose() {
    _notasController.dispose();
    super.dispose();
  }

  void _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    if (widget.initial?.resultadoReconocimiento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falta resultado de reconocimiento')),
      );
      return;
    }
    final obs = Observacion(
      observationId: widget.initial?.observationId ?? '',
      fechaHora: DateTime.now(),
      notasAdicionales: _notasController.text,
      estado: EstadoObservacion.borrador,
      modoOffline: _modoOffline,
      participanteId: widget.participanteId,
      resultadoReconocimiento: widget.initial!.resultadoReconocimiento,
      especieIdentificada: widget.initial?.especieIdentificada,
      caracteristicas: widget.initial?.caracteristicas,
      archivos: widget.initial?.archivos ?? [],
    );
    await ref.read(createObservacionProvider(obs).future);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Observación')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _notasController,
                decoration: const InputDecoration(labelText: 'Notas adicionales'),
              ),
              SwitchListTile(
                value: _modoOffline,
                onChanged: (v) => setState(() => _modoOffline = v),
                title: const Text('Modo offline'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _guardar,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 