import 'package:flutter/material.dart';
import '../../domain/entities/caracteristicas_observacion.dart';

class CharacteristicsFormWidget extends StatefulWidget {
  final CaracteristicasObservacion? caracteristicas;
  final Function(CaracteristicasObservacion) onCharacteristicsChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const CharacteristicsFormWidget({
    super.key,
    this.caracteristicas,
    required this.onCharacteristicsChanged,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<CharacteristicsFormWidget> createState() => _CharacteristicsFormWidgetState();
}

class _CharacteristicsFormWidgetState extends State<CharacteristicsFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _colorController;
  FormaPico _formaPico = FormaPico.desconocido;
  TamanoAve _tamanoAve = TamanoAve.desconocido;

  @override
  void initState() {
    super.initState();
    _colorController = TextEditingController(text: widget.caracteristicas?.colorPredominante ?? '');
    _formaPico = widget.caracteristicas?.formaPico ?? FormaPico.desconocido;
    _tamanoAve = widget.caracteristicas?.tamanoAve ?? TamanoAve.desconocido;
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _colorController,
            decoration: const InputDecoration(labelText: 'Color predominante'),
          ),
          DropdownButton<FormaPico>(
            value: _formaPico,
            items: FormaPico.values.map((fp) {
              return DropdownMenuItem(
                value: fp,
                child: Text(fp.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _formaPico = value!;
              });
            },
          ),
          DropdownButton<TamanoAve>(
            value: _tamanoAve,
            items: TamanoAve.values.map((t) {
              return DropdownMenuItem(
                value: t,
                child: Text(t.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _tamanoAve = value!;
              });
            },
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onBack,
                  child: const Text('Atrás'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onCharacteristicsChanged(
                      CaracteristicasObservacion(
                        featureId: DateTime.now().millisecondsSinceEpoch.toString(),
                        colorPredominante: _colorController.text,
                        formaPico: _formaPico,
                        tamanoAve: _tamanoAve,
                      ),
                    );
                    widget.onNext();
                  },
                  child: const Text('Siguiente'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 