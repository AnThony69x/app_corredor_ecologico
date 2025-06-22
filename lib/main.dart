import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar archivo .env con las claves de Supabase
  await dotenv.load(fileName: ".env");

  // Inicializar Supabase
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );
  // Verificar conexión a Supabase
  final response = await Supabase.instance.client.from('profiles').select().limit(1).execute();
  if (response.status == 200 && response.data != null) {
    print("✅ Conectado y datos recibidos de Supabase");
  } else {
    print("❌ Error al conectar: status ${response.status}");
    print(response.data);
  }
      
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corredor Ecológico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Primera pantalla (puede ser splash o login)
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Bienvenido a Corredor Ecológico",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
