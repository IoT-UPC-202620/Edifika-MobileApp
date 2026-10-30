import 'package:flutter/material.dart';

/// Tokens de diseño de la app móvil.
///
/// Colores medidos sobre los PNG que renderiza Figma (Mockups 01–12, el
/// archivo no define variables). Radios y espaciados son aproximados a partir
/// de las capturas; ver README → Diseño.
class AppColors {
  const AppColors._();

  static const primary = Color(0xFF8B088F);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFF6EBF7);

  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF221920);
  static const onSurfaceVariant = Color(0xFF756A75);
  static const outline = Color(0xFFEAE4EC);

  static const success = Color(0xFF217350);
  static const successContainer = Color(0xFFEDF7F1);
  static const error = Color(0xFFB13B42);
  static const errorContainer = Color(0xFFFFF0F0);
}

class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;

  /// Margen lateral de las pantallas.
  static const double screen = 20;
}

class AppRadius {
  const AppRadius._();

  static const double chip = 6;
  static const double button = 10;
  static const double card = 14;
}
