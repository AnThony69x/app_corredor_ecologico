import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/env.dart';
import 'core/theme/app_theme.dart';
import 'features/observation/presentation/screens/lista_aves_screen.dart';
import 'features/observation/presentation/screens/registro_observacion_screen.dart';
import 'main_menu_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive para almacenamiento local
  await Hive.initFlutter();

  // Inicializar Supabase
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Corredor Ecológico',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Usar tema del sistema
      debugShowCheckedModeBanner: false,
      home: const MainMenuScreen(),
    );
  }
}

class MenuPrincipalScreen extends StatelessWidget {
  const MenuPrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Corredor Ecológico')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('Lista de Especies'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListaAvesScreen()),
                );
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Registrar Observación'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegistroObservacionScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? conexionMensaje;
  String? detalleError;
  bool comprobando = true;

  @override
  void initState() {
    super.initState();
    verificarConexion();
  }

  Future<void> verificarConexion() async {
    try {
      await Supabase.instance.client.from('profiles').select().limit(1);

      setState(() {
        conexionMensaje = "✅ Conectado a la base de datos";
        detalleError = null;
        comprobando = false;
      });

      // Opcional: Navega a la pantalla principal después de un breve delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "Hola mundo"),
            ),
          );
        }
      });
    } catch (e) {
      setState(() {
        conexionMensaje = "❌ Error al conectar a la base de datos";
        detalleError = e.toString();
        comprobando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido a Corredor Ecológico",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (comprobando)
              const CircularProgressIndicator()
            else if (conexionMensaje != null)
              Text(
                conexionMensaje!,
                style: TextStyle(
                  fontSize: 18,
                  color: conexionMensaje!.contains('✅')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            if (detalleError != null &&
                conexionMensaje != null &&
                conexionMensaje!.contains('❌'))
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 24, right: 24),
                child: Text(
                  detalleError!,
                  style: const TextStyle(fontSize: 14, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
