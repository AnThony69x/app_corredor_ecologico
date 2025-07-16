import 'package:flutter/material.dart';

class AppAnimations {
  // Duración de animaciones
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Curvas de animación
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve bounceOut = Curves.bounceOut;

  // Animación de página
  static PageRouteBuilder<T> createPageRoute<T>({
    required Widget child,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: normal,
    );
  }

  // Animación de fade
  static Widget fadeIn({
    required Widget child,
    Duration duration = normal,
    Curve curve = easeInOut,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // Animación de slide
  static Widget slideIn({
    required Widget child,
    Offset begin = const Offset(0, 0.3),
    Duration duration = normal,
    Curve curve = easeOut,
  }) {
    return TweenAnimationBuilder<Offset>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: begin, end: Offset.zero),
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // Animación de scale
  static Widget scaleIn({
    required Widget child,
    double begin = 0.8,
    Duration duration = normal,
    Curve curve = elasticOut,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: begin, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // Animación de bounce
  static Widget bounceIn({
    required Widget child,
    Duration duration = slow,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: bounceOut,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // Animación de pulse
  static Widget pulse({
    required Widget child,
    Duration duration = normal,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 1.0, end: 1.1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // Animación de shimmer
  static Widget shimmer({
    required Widget child,
    Duration duration = slow,
  }) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
            Colors.grey[300]!,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(bounds);
      },
      child: child,
    );
  }

  // Animación de loading
  static Widget loadingAnimation({
    double size = 40,
    Color color = const Color(0xFF4CAF50),
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 3,
      ),
    );
  }

  // Animación de progreso
  static Widget progressAnimation({
    required double value,
    Duration duration = normal,
    Color color = const Color(0xFF4CAF50),
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0.0, end: value),
      builder: (context, value, child) {
        return LinearProgressIndicator(
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          backgroundColor: Colors.grey[300],
        );
      },
    );
  }

  // Animación de contador
  static Widget counterAnimation({
    required int value,
    Duration duration = normal,
    TextStyle? style,
  }) {
    return TweenAnimationBuilder<int>(
      duration: duration,
      tween: Tween(begin: 0, end: value),
      builder: (context, value, child) {
        return Text(
          value.toString(),
          style: style ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  // Animación de lista
  static Widget listItemAnimation({
    required Widget child,
    required int index,
    Duration duration = normal,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: duration.inMilliseconds + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Animación de botón
  static Widget buttonAnimation({
    required Widget child,
    required VoidCallback onPressed,
    Duration duration = fast,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 1.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: GestureDetector(
            onTapDown: (_) {
              // Efecto de presión
            },
            onTap: onPressed,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Animación de tarjeta
  static Widget cardAnimation({
    required Widget child,
    Duration duration = normal,
    Curve curve = easeOut,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Animación de icono
  static Widget iconAnimation({
    required IconData icon,
    double size = 24,
    Color color = const Color(0xFF4CAF50),
    Duration duration = normal,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 2 * 3.14159,
          child: Icon(
            icon,
            size: size,
            color: color,
          ),
        );
      },
    );
  }

  // Animación de texto
  static Widget textAnimation({
    required String text,
    TextStyle? style,
    Duration duration = normal,
  }) {
    return TweenAnimationBuilder<int>(
      duration: duration,
      tween: Tween(begin: 0, end: text.length),
      builder: (context, value, child) {
        return Text(
          text.substring(0, value),
          style: style,
        );
      },
    );
  }

  // Animación de color
  static Widget colorAnimation({
    required Widget child,
    required Color beginColor,
    required Color endColor,
    Duration duration = normal,
  }) {
    return TweenAnimationBuilder<Color>(
      duration: duration,
      tween: Tween<Color>(begin: beginColor, end: endColor),
      builder: (context, value, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(value, BlendMode.srcIn),
          child: child,
        );
      },
      child: child,
    );
  }

  // Configuración de Hero
  static Hero heroAnimation({
    required String tag,
    required Widget child,
  }) {
    return Hero(
      tag: tag,
      child: child,
    );
  }

  // Animación de transición personalizada
  static Widget customTransition({
    required Widget child,
    required Animation<double> animation,
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
    Curve curve = easeInOut,
  }) {
    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

// Clase para animaciones de microinteracciones
class MicroInteractions {
  // Vibración táctil
  static void hapticFeedback() {
    // Implementar feedback háptico
  }

  // Animación de ripple
  static Widget rippleEffect({
    required Widget child,
    Color color = const Color(0xFF4CAF50),
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: color.withValues(alpha: 0.3),
        highlightColor: color.withValues(alpha: 0.1),
        child: child,
      ),
    );
  }

  // Animación de focus
  static Widget focusAnimation({
    required Widget child,
    Color focusColor = const Color(0xFF4CAF50),
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        // Manejar cambio de focus
      },
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: focusColor.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: child,
      ),
    );
  }
} 