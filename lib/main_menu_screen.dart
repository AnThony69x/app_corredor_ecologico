import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'features/observation/presentation/screens/home_screen.dart';
import 'features/map/presentation/screens/observations_map_screen.dart';
import 'features/participant/presentation/screens/profile_screen.dart';
import 'features/observation/data/models/especie_model.dart';
import 'features/species/presentation/screens/species_detail_screen.dart';

class SpeciesListScreen extends StatelessWidget {
  const SpeciesListScreen({super.key});

  Future<List<EspecieModel>> cargarEspecies() async {
    final String jsonString = await rootBundle.loadString('assets/aves.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => EspecieModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Especies')),
      body: FutureBuilder<List<EspecieModel>>(
        future: cargarEspecies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay especies disponibles'));
          }
          final especies = snapshot.data!;
          return ListView.builder(
            itemCount: especies.length,
            itemBuilder: (context, i) {
              final especie = especies[i];
              return ListTile(
                title: Text(especie.nombreComun),
                subtitle: Text(especie.nombreCientifico),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SpeciesDetailScreen(especie: especie),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ObservationsMapScreen(),
    SpeciesListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Especies'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
