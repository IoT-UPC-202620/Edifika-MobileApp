import 'package:flutter/material.dart';

import 'app_tokens.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.primary,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.error,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outline,
    );

    // Escala tipográfica estimada desde las alturas de texto en Figma.
    const textTheme = TextTheme(
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: AppColors.primary, height: 1.2),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.onSurface, height: 1.2),
      headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.onSurface, height: 1.25),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.onSurface, height: 1.3),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.onSurface, height: 1.3),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.onSurface, height: 1.4),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant, height: 1.4),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant, height: 1.3),
      labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.2),
      labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onSurface, height: 1.3),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2),
    );

    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button));
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.button),
      borderSide: const BorderSide(color: AppColors.outline),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.surface,
      dividerColor: AppColors.outline,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: buttonShape,
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary, textStyle: textTheme.labelMedium),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(borderSide: const BorderSide(color: AppColors.primary, width: 2)),
        errorBorder: inputBorder.copyWith(borderSide: const BorderSide(color: AppColors.error)),
        suffixIconColor: AppColors.onSurfaceVariant,
        hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.onSurfaceVariant, width: 1.5),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: Colors.transparent,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w400,
            color: states.contains(WidgetState.selected) ? AppColors.primary : AppColors.onSurfaceVariant,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected) ? AppColors.primary : AppColors.onSurfaceVariant,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
