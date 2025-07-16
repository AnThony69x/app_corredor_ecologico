# 🚀 Guía de Configuración - Corredor Ecológico

## ✅ Estado de la Instalación

### ✅ Completado:
- [x] Estructura del proyecto creada
- [x] Dependencias instaladas
- [x] Configuración de Android (permisos)
- [x] Configuración de iOS (permisos)
- [x] Sistema de navegación configurado
- [x] Providers de Riverpod creados
- [x] Emulador Android disponible
- [x] Flutter Doctor sin errores

### ⚠️ Pendiente:
- [ ] Configurar Supabase
- [ ] Probar la aplicación

## 🔧 Configuración de Supabase

### 1. Crear cuenta en Supabase
1. Ve a [https://supabase.com](https://supabase.com)
2. Crea una cuenta gratuita
3. Crea un nuevo proyecto

### 2. Obtener credenciales
1. En tu proyecto de Supabase, ve a **Settings** → **API**
2. Copia la **URL** y **anon public key**
3. Actualiza `lib/core/env.dart`:

```dart
static const String supabaseUrl = 'TU_SUPABASE_URL_AQUI';
static const String supabaseAnonKey = 'TU_SUPABASE_ANON_KEY_AQUI';
```

### 3. Crear tablas en Supabase
Ejecuta este SQL en el editor SQL de Supabase:

```sql
-- Tabla de usuarios
CREATE TABLE profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE,
  email TEXT,
  full_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
  PRIMARY KEY (id)
);

-- Tabla de observaciones de aves
CREATE TABLE bird_observations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  bird_name TEXT NOT NULL,
  description TEXT,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  image_url TEXT,
  audio_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Tabla de tours
CREATE TABLE tours (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  distance_km DOUBLE PRECISION,
  duration_minutes INTEGER,
  difficulty TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);
```

## 📱 Ejecutar la Aplicación

### Opción 1: Emulador Android
```bash
# El emulador ya está configurado
flutter run
```

### Opción 2: Navegador Web
```bash
flutter run -d chrome
```

### Opción 3: Dispositivo Físico
1. Conecta tu dispositivo Android por USB
2. Activa "Opciones de desarrollador" y "Depuración USB"
3. Ejecuta: `flutter run`

## 🐛 Solución de Problemas Comunes

### Error: "Building with plugins requires symlink support"
**Solución**: Habilitar modo desarrollador en Windows
1. Presiona `Windows + R`
2. Ejecuta: `ms-settings:developers`
3. Activa "Modo desarrollador"

### Error: "No connected devices"
**Solución**: 
1. Verifica que el emulador esté ejecutándose
2. Ejecuta: `flutter devices`
3. Si no hay emuladores: `flutter emulators --create --name Pixel_4_API_30`

### Error: "Supabase connection failed"
**Solución**:
1. Verifica las credenciales en `lib/core/env.dart`
2. Asegúrate de que el proyecto de Supabase esté activo
3. Verifica la conexión a internet

## 📊 Comandos Útiles

```bash
# Verificar configuración
flutter doctor

# Limpiar proyecto
flutter clean

# Obtener dependencias
flutter pub get

# Analizar código
flutter analyze

# Ejecutar tests
flutter test

# Construir APK
flutter build apk

# Ver dispositivos
flutter devices

# Ver emuladores
flutter emulators
```

## 🎯 Próximos Pasos

1. **Configurar Supabase** (obligatorio)
2. **Probar la aplicación** en emulador o dispositivo
3. **Personalizar la interfaz** según necesidades
4. **Agregar funcionalidades** específicas
5. **Configurar CI/CD** para despliegue

## 📞 Soporte

Si encuentras problemas:
1. Revisa el README.md
2. Ejecuta `flutter doctor -v`
3. Verifica los logs de error
4. Contacta al equipo de desarrollo

---

¡Tu aplicación Corredor Ecológico está lista para ser configurada! 🦅 