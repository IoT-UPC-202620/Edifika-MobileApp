import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/config/app_config.dart';
import 'app_dependencies.dart';

class EdifikaApp extends StatelessWidget {
  EdifikaApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const _PendingDesignScreen()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: dependencies.auth),
        RepositoryProvider.value(value: dependencies.residential),
        RepositoryProvider.value(value: dependencies.payments),
        RepositoryProvider.value(value: dependencies.reservations),
        RepositoryProvider.value(value: dependencies.forum),
        RepositoryProvider.value(value: dependencies.notifications),
        RepositoryProvider.value(value: dependencies.announcements),
        RepositoryProvider.value(value: dependencies.profile),
      ],
      child: MaterialApp.router(
        title: 'Edifika',
        debugShowCheckedModeBanner: false,
        // TODO(design): reemplazar por core/theme generado desde los tokens de Figma.
        theme: ThemeData(useMaterial3: true),
        routerConfig: _router,
      ),
    );
  }
}

/// Pantalla temporal hasta tener el inventario de diseño de Figma.
class _PendingDesignScreen extends StatelessWidget {
  const _PendingDesignScreen();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edifika', style: textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Pantallas pendientes del diseño en Figma.', style: textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text('API: ${AppConfig.apiBaseUrl}', style: textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
