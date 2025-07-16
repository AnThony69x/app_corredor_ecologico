# 🦅 Corredor Ecológico

Aplicación móvil para observación de aves y tours ecológicos desarrollada con Flutter.

## 📱 Características

- 🔐 Autenticación con Supabase
- 📍 Geolocalización en tiempo real
- 📷 Captura de fotos de aves
- 🎵 Grabación de sonidos
- 🗺️ Tours ecológicos
- 📊 Estadísticas de observaciones
- 💾 Almacenamiento offline
- 🌙 Modo oscuro

## 🛠️ Requisitos Previos

### Flutter SDK
- **Versión**: ^3.8.1
- **Instalación**: [Guía oficial de Flutter](https://docs.flutter.dev/get-started/install/windows)

### Android Studio (Recomendado)
- **Descarga**: [Android Studio](https://developer.android.com/studio)
- **Plugins necesarios**:
  - Flutter
  - Dart

### Visual Studio Code (Opcional)
- **Extensiones**:
  - Flutter
  - Dart
  - Flutter Widget Snippets

## 🚀 Instalación

### 1. Clonar el repositorio
```bash
git clone <url-del-repositorio>
cd app_corredor_ecologico
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Configurar Supabase
1. Crear cuenta en [Supabase](https://supabase.com)
2. Crear un nuevo proyecto
3. Obtener URL y anonKey desde Settings → API
4. Actualizar `lib/core/env.dart`:
```dart
static const String supabaseUrl = 'TU_SUPABASE_URL';
static const String supabaseAnonKey = 'TU_SUPABASE_ANON_KEY';
```

### 4. Configurar emulador/dispositivo
```bash
# Verificar dispositivos disponibles
flutter devices

# Crear emulador Android (opcional)
flutter emulators --create --name Pixel_4_API_30
flutter emulators --launch Pixel_4_API_30
```

### 5. Ejecutar la aplicación
```bash
flutter run
```

## 📁 Estructura del Proyecto

```
lib/
├── core/
│   ├── env.dart              # Configuración de variables de entorno
│   ├── providers/            # Providers de Riverpod
│   └── router/               # Configuración de navegación
├── features/
│   ├── auth/                 # Autenticación
│   ├── home/                 # Pantalla principal
│   ├── birds/                # Observación de aves
│   ├── tours/                # Tours ecológicos
│   └── profile/              # Perfil de usuario
└── main.dart                 # Punto de entrada
```

## 🔧 Dependencias Principales

- **`supabase_flutter`**: Base de datos en la nube
- **`flutter_riverpod`**: Gestión de estado
- **`go_router`**: Navegación
- **`geolocator`**: Geolocalización
- **`image_picker`**: Selección de imágenes
- **`audioplayers`**: Reproducción de audio
- **`hive`**: Base de datos local
- **`flutter_dotenv`**: Variables de entorno

## 📱 Permisos Requeridos

### Android
- Ubicación (FINE y COARSE)
- Cámara
- Almacenamiento
- Internet

### iOS
- Ubicación (WhenInUse)
- Cámara
- Micrófono
- Galería de fotos

## 🐛 Solución de Problemas

### Error de dependencias
```bash
flutter clean
flutter pub get
```

### Error de permisos
- Verificar que los permisos estén configurados en AndroidManifest.xml e Info.plist
- Reiniciar el emulador/dispositivo

### Error de Supabase
- Verificar que las credenciales estén correctas en `lib/core/env.dart`
- Comprobar que el proyecto de Supabase esté activo

## 📊 Comandos Útiles

```bash
# Verificar configuración
flutter doctor

# Analizar código
flutter analyze

# Ejecutar tests
flutter test

# Construir APK
flutter build apk

# Construir para iOS
flutter build ios
```

## 🤝 Contribuir

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 📞 Soporte

Para soporte técnico, contacta a:
- Email: soporte@corredorecologico.com
- Discord: [Servidor de la comunidad](https://discord.gg/corredorecologico)

---

Desarrollado con ❤️ para la conservación de la biodiversidad
