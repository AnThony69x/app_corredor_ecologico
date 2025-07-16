class Env {
  // Supabase Configuration
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://tu-proyecto.supabase.co',
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'tu-anon-key-aqui',
  );
  
  // App Configuration
  static const String appName = 'Corredor Ecológico';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String apiBaseUrl = 'https://api.corredorecologico.com';
  
  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enableLocationTracking = true;
  static const bool enableAudioRecording = true;
}
