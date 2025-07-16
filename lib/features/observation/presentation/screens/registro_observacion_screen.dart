import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/observacion.dart';
import '../../domain/entities/especie.dart';

class RegistroObservacionScreen extends StatefulWidget {
  const RegistroObservacionScreen({super.key});

  @override
  State<RegistroObservacionScreen> createState() => _RegistroObservacionScreenState();
}

class _RegistroObservacionScreenState extends State<RegistroObservacionScreen> {
  int _currentStep = 0;
  String? _especieId;
  String? _fotoPath;
  String? _audioPath;
  List<Especie> _especies = [];
  bool _loadingEspecies = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _cargarEspecies();
  }

  Future<void> _cargarEspecies() async {
    final String data = await rootBundle.loadString('assets/aves.json');
    final List<dynamic> jsonList = json.decode(data);
    setState(() {
      _especies = jsonList.map((e) => Especie.fromJson(e)).toList();
      _loadingEspecies = false;
    });
  }

  Future<void> guardarObservacion(Observacion obs) async {
    final box = await Hive.openBox<Observacion>('observaciones');
    await box.add(obs);
  }

  void _guardar() async {
    if (_especieId != null && _fotoPath != null) {
      final obs = Observacion.simple(
        especieId: _especieId!,
        fotoPath: _fotoPath!,
        audioPath: _audioPath,
        fecha: DateTime.now(),
      );
      await guardarObservacion(obs);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Observación guardada!')),
      );
      Navigator.pop(context);
    }
  }

  bool get _canContinue {
    if (_currentStep == 0) {
      return _fotoPath != null;
    } else if (_currentStep == 1) {
      return _especieId != null;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Observación')),
      body: _loadingEspecies
          ? const Center(child: CircularProgressIndicator())
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _canContinue
                  ? () {
                      if (_currentStep < 2) {
                        setState(() => _currentStep += 1);
                      } else {
                        _guardar();
                      }
                    }
                  : null,
              onStepCancel: () {
                if (_currentStep > 0) setState(() => _currentStep -= 1);
              },
              steps: [
                Step(
                  title: const Text('Foto'),
                  content: Column(
                    children: [
                      _fotoPath != null
                          ? Image.file(
                              File(_fotoPath!),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : const Text('No se ha seleccionado foto'),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.photo_camera),
                        label: const Text('Seleccionar Foto'),
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _fotoPath = image.path;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: const Text('Especie'),
                  content: DropdownButtonFormField<String>(
                    value: _especieId,
                    items: _especies
                        .map((e) => DropdownMenuItem(
                              value: e.especieId,
                              child: Text(e.nombreComun),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => _especieId = val),
                    decoration: const InputDecoration(labelText: 'Selecciona la especie'),
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: const Text('Audio (opcional)'),
                  content: ElevatedButton(
                    onPressed: () async {
                      // Aquí puedes implementar la grabación de audio real si lo deseas
                    },
                    child: const Text('Grabar Audio'),
                  ),
                  isActive: _currentStep == 2,
                ),
              ],
            ),
    );
  }
} 