import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../domain/entities/especie.dart';

class ListaAvesScreen extends StatefulWidget {
  const ListaAvesScreen({super.key});

  @override
  State<ListaAvesScreen> createState() => _ListaAvesScreenState();
}

class _ListaAvesScreenState extends State<ListaAvesScreen> {
  List<Especie> especies = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    cargarAves();
  }

  Future<void> cargarAves() async {
    final String data = await rootBundle.loadString('assets/aves.json');
    final List<dynamic> jsonList = json.decode(data);
    setState(() {
      especies = jsonList.map((e) => Especie.fromJson(e)).toList();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Especies')),
      body: especies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: especies.length,
              itemBuilder: (context, index) {
                final ave = especies[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ave.fotoUrl != null
                        ? Image.network(ave.fotoUrl!, width: 56, height: 56, fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported),
                    title: Text(ave.nombreComun),
                    subtitle: Text(ave.nombreCientifico),
                    trailing: IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: ave.audioUrl != null
                          ? () async {
                              await _audioPlayer.play(UrlSource(ave.audioUrl!));
                            }
                          : null,
                    ),
                  ),
                );
              },
            ),
    );
  }
} 