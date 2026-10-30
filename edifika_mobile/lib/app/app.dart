import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/session_cubit.dart';
import 'app_dependencies.dart';
import 'app_router.dart';

class EdifikaApp extends StatefulWidget {
  const EdifikaApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  State<EdifikaApp> createState() => _EdifikaAppState();
}

class _EdifikaAppState extends State<EdifikaApp> {
  late final SessionCubit _session;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final deps = widget.dependencies;
    _session = SessionCubit(
      auth: deps.auth,
      residential: deps.residential,
      sessionExpired: deps.sessionExpired.stream,
    )..restore();
    _router = createRouter(_session);
  }

  @override
  void dispose() {
    _router.dispose();
    _session.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deps = widget.dependencies;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: deps.auth),
        RepositoryProvider.value(value: deps.residential),
        RepositoryProvider.value(value: deps.payments),
        RepositoryProvider.value(value: deps.reservations),
        RepositoryProvider.value(value: deps.forum),
        RepositoryProvider.value(value: deps.notifications),
        RepositoryProvider.value(value: deps.announcements),
        RepositoryProvider.value(value: deps.profile),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _session),
          RepositoryProvider.value(value: deps.dataChanges),
        ],
        child: MaterialApp.router(
          title: 'Edifika',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          locale: const Locale('es', 'PE'),
          supportedLocales: const [Locale('es', 'PE'), Locale('es')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          routerConfig: _router,
        ),
      ),
    );
  }
}
