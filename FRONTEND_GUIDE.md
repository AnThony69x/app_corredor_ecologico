# 🐦 Guía del Frontend - Módulo de Observación de Aves

## 📱 Descripción General

El módulo de observación de aves presenta una interfaz gráfica moderna y funcional diseñada para facilitar el registro y gestión de observaciones ornitológicas. La aplicación sigue los principios de Material Design 3 y ofrece una experiencia de usuario intuitiva y accesible.

## 🎨 Características del Diseño

### Paleta de Colores
- **Color Primario**: `#4CAF50` (Verde)
- **Color Primario Oscuro**: `#2E7D32` (Verde oscuro)
- **Color Primario Claro**: `#81C784` (Verde claro)
- **Color Secundario**: `#2196F3` (Azul)
- **Color de Acento**: `#FF9800` (Naranja)

### Tipografía
- **Títulos**: Roboto Bold, 24px
- **Subtítulos**: Roboto SemiBold, 18px
- **Cuerpo**: Roboto Regular, 16px
- **Captions**: Roboto Medium, 14px

## 🏗️ Arquitectura de Componentes

### 1. Pantalla Principal (HomeScreen)
**Ubicación**: `lib/features/observation/presentation/screens/home_screen.dart`

**Características**:
- Header con saludo personalizado y barra de búsqueda
- Listado de observaciones recientes con miniaturas
- Botón flotante "+" para nueva observación
- Menú inferior con 4 opciones: Inicio, Mapa, Especies, Perfil
- Estados vacíos y de carga optimizados

**Componentes principales**:
```dart
- _buildHeader() // Header con búsqueda
- _buildObservationsList() // Lista de observaciones
- _buildEmptyState() // Estado sin observaciones
- _buildBottomNavigationBar() // Menú inferior
```

### 2. Tarjeta de Observación (ObservationCard)
**Ubicación**: `lib/features/observation/presentation/widgets/observation_card.dart`

**Características**:
- Diseño de tarjeta moderna con sombras
- Imagen de la observación con overlay
- Información de especie (nombre común y científico)
- Indicador de estado visual
- Información de fecha y ubicación
- Preview de archivos multimedia

**Elementos visuales**:
- Imagen con overlay de cuadrícula
- Chip de estado con colores diferenciados
- Indicador de archivos multimedia
- Información de modo offline

### 3. Flujo de Creación de Observación

#### 3.1 Captura de Media (MediaCaptureWidget)
**Ubicación**: `lib/features/observation/presentation/widgets/media_capture_widget.dart`

**Características**:
- Overlay con cuadrícula para composición
- Indicador de calidad de imagen en tiempo real
- Botones para alternar entre cámara/micrófono
- Tiempo máximo de grabación: 30 segundos
- Preview de archivos capturados

**Funcionalidades**:
```dart
- _buildCaptureArea() // Área de captura
- _buildGridOverlay() // Cuadrícula de composición
- _buildQualityIndicator() // Indicador de calidad
- _buildCaptureControls() // Controles de captura
```

#### 3.2 Formulario de Características (CharacteristicsFormWidget)
**Ubicación**: `lib/features/observation/presentation/widgets/characteristics_form_widget.dart`

**Campos incluidos**:
- Tamaño del ave (Pequeño, Mediano, Grande)
- Color principal (9 opciones predefinidas)
- Hábitat (6 tipos de hábitat)
- Comportamiento observado (6 comportamientos)
- Características adicionales (migratoria, diurna)
- Notas adicionales

**Componentes**:
```dart
- _buildDropdownSelector() // Selectores desplegables
- _buildCheckboxGroup() // Grupo de checkboxes
- _buildNotesField() // Campo de notas
```

#### 3.3 Confirmación Geográfica (LocationConfirmationWidget)
**Ubicación**: `lib/features/observation/presentation/widgets/location_confirmation_widget.dart`

**Características**:
- Mapa interactivo (preparado para Leaflet/MapLibre)
- Marcador arrastrable para ajuste manual
- Panel lateral con información de ubicación
- Indicador de precisión GPS visual
- Botón "Usar mi ubicación actual"
- Campo para notas de ubicación

**Funcionalidades**:
```dart
- _buildMapSection() // Sección del mapa
- _buildGpsAccuracyIndicator() // Indicador de precisión
- _buildCurrentLocationButton() // Botón de ubicación actual
- _buildCoordinatesInfo() // Información de coordenadas
```

#### 3.4 Resultado de Reconocimiento (RecognitionResultWidget)
**Ubicación**: `lib/features/observation/presentation/widgets/recognition_result_widget.dart`

**Características**:
- Estado de procesamiento con animación
- Tarjetas de especies candidatas
- Barras de confianza visuales
- Información detallada de cada especie
- Opciones de confianza personalizada
- Botones de acción (más info, reportar)

**Estados**:
```dart
- _buildProcessingState() // Estado de procesamiento
- _buildResultsContent() // Contenido de resultados
- _buildSpeciesCard() // Tarjeta de especie
- _buildNoResultsState() // Estado sin resultados
```

## 🎯 Flujo de Usuario

### 1. Pantalla de Inicio
1. Usuario ve listado de observaciones recientes
2. Puede buscar observaciones existentes
3. Toca botón "+" para nueva observación

### 2. Captura de Media
1. Selecciona modo (cámara/audio)
2. Captura imagen o graba audio
3. Revisa archivos capturados
4. Continúa al siguiente paso

### 3. Características
1. Completa formulario de características
2. Selecciona opciones de dropdown
3. Marca características adicionales
4. Añade notas si es necesario

### 4. Ubicación
1. Confirma ubicación en mapa
2. Ajusta marcador si es necesario
3. Revisa precisión GPS
4. Añade notas de ubicación

### 5. Resultado
1. Ve resultado del reconocimiento
2. Selecciona especie correcta
3. Ajusta confianza si es necesario
4. Guarda la observación

## 🎨 Sistema de Temas

### Tema Claro (AppTheme.lightTheme)
- Fondo principal: `#F5F5F5`
- Superficies: `#FFFFFF`
- Texto primario: `#212121`
- Texto secundario: `#757575`

### Tema Oscuro (AppTheme.darkTheme)
- Fondo principal: `#121212`
- Superficies: `#1E1E1E`
- Texto primario: `#FFFFFF`
- Texto secundario: `#B0B0B0`

### Variables CSS Equivalentes
```css
:root {
  --primary-color: #4CAF50;
  --primary-dark: #2E7D32;
  --primary-light: #81C784;
  --secondary-color: #2196F3;
  --accent-color: #FF9800;
  --background-color: #F5F5F5;
  --surface-color: #FFFFFF;
  --text-primary: #212121;
  --text-secondary: #757575;
  --border-color: #E0E0E0;
}
```

## 📱 Responsive Design

### Breakpoints
- **Mobile (default)**: 360-767px
- **Tablet**: 768-1023px
- **Desktop**: 1024px+

### Adaptaciones
- Layout flexible con `Expanded` y `Flex`
- Tamaños de fuente responsivos
- Espaciado adaptativo
- Navegación optimizada para móvil

## ♿ Accesibilidad

### Consideraciones Implementadas
- **Contraste**: Mínimo 4.5:1 para texto
- **Etiquetas**: Textos descriptivos para elementos interactivos
- **Navegación**: Soporte para navegación por teclado
- **Iconos**: Alternativas textuales disponibles
- **Tamaños**: Elementos táctiles mínimos de 44px

### Mejoras Sugeridas
- Implementar `Semantics` widgets
- Añadir soporte para lectores de pantalla
- Optimizar para navegación por voz

## 🎭 Animaciones y Microinteracciones

### Transiciones Implementadas
- Transiciones suaves entre pasos (300ms)
- Animación de carga durante reconocimiento
- Feedback táctil en interacciones
- Animaciones de entrada/salida

### Efectos Visuales
- Sombras dinámicas en tarjetas
- Efectos de hover en botones
- Animaciones de progreso
- Transiciones de estado

## 🚀 Instalación y Uso

### Dependencias Requeridas
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  supabase_flutter: ^1.10.25
  image_picker: ^1.0.7
  geolocator: ^11.0.0
  hive_flutter: ^1.1.0
```

### Configuración
1. Asegúrate de tener Flutter instalado
2. Ejecuta `flutter pub get`
3. Configura las variables de entorno en `lib/core/env.dart`
4. Ejecuta `flutter run`

### Estructura de Archivos
```
lib/
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   └── env.dart
├── features/
│   └── observation/
│       └── presentation/
│           ├── screens/
│           │   ├── home_screen.dart
│           │   └── create_observation_screen.dart
│           └── widgets/
│               ├── observation_card.dart
│               ├── media_capture_widget.dart
│               ├── characteristics_form_widget.dart
│               ├── location_confirmation_widget.dart
│               └── recognition_result_widget.dart
└── main.dart
```

## 🔧 Personalización

### Modificar Colores
Edita `lib/core/theme/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF4CAF50);
static const Color primaryDarkColor = Color(0xFF2E7D32);
```

### Añadir Nuevos Componentes
1. Crea el widget en `lib/features/observation/presentation/widgets/`
2. Importa en la pantalla correspondiente
3. Aplica estilos del tema

### Modificar Flujo
1. Edita `create_observation_screen.dart`
2. Añade/remueve pasos según necesidad
3. Actualiza indicador de progreso

## 📊 Métricas de Rendimiento

### Optimizaciones Implementadas
- Uso de `const` constructors
- Lazy loading de listas
- Caché de imágenes
- Debounce en búsquedas

### Monitoreo Sugerido
- Tiempo de carga de pantallas
- Uso de memoria
- Rendimiento de animaciones
- Tasa de errores

## 🐛 Solución de Problemas

### Problemas Comunes
1. **Error de permisos de cámara**: Verificar permisos en `AndroidManifest.xml`
2. **Error de ubicación**: Verificar permisos de GPS
3. **Error de conexión**: Verificar configuración de Supabase

### Debug
- Usa `flutter doctor` para verificar instalación
- Revisa logs con `flutter logs`
- Verifica dependencias con `flutter pub deps`

## 📈 Próximas Mejoras

### Funcionalidades Planificadas
- [ ] Modo offline completo
- [ ] Sincronización automática
- [ ] Exportación de datos
- [ ] Estadísticas avanzadas
- [ ] Integración con APIs externas

### Mejoras de UX
- [ ] Tutorial interactivo
- [ ] Sugerencias inteligentes
- [ ] Modo accesibilidad avanzado
- [ ] Temas personalizables

---

**Desarrollado con ❤️ para la conservación de aves** 