import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(), // Ponemos SplashScreen como pantalla inicial
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
      await Supabase.instance.client
          .from('profiles')
          .select()
          .limit(1);

      setState(() {
        conexionMensaje = "✅ Conectado a la base de datos";
        detalleError = null;
        comprobando = false;
      });

      // Opcional: Navega a la pantalla principal después de un breve delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "Hola mundo")));
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
                  color: conexionMensaje!.contains('✅') ? Colors.green : Colors.red,
                ),
              ),
            if (detalleError != null && conexionMensaje != null && conexionMensaje!.contains('❌'))
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