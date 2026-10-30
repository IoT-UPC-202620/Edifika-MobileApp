import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/feedback_views.dart';
import '../features/announcements/presentation/announcements_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/session_cubit.dart';
import '../features/forum/presentation/community_screen.dart';
import '../features/forum/presentation/new_post_screen.dart';
import '../features/forum/presentation/post_detail_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';
import '../features/payments/presentation/debts_screen.dart';
import '../features/payments/presentation/payments_screen.dart';
import '../features/reservations/presentation/new_reservation_screen.dart';
import '../features/reservations/presentation/reservation_detail_screen.dart';
import '../features/reservations/presentation/reservation_routes_args.dart';
import '../features/reservations/presentation/reservations_screen.dart';

GoRouter createRouter(SessionCubit session) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: _StreamListenable(session.stream),
    redirect: (context, state) {
      final location = state.matchedLocation;
      return switch (session.state.status) {
        SessionStatus.unknown => location == '/splash' ? null : '/splash',
        SessionStatus.unauthenticated => location == '/login' ? null : '/login',
        SessionStatus.authenticated => location == '/login' || location == '/splash' ? '/home' : null,
      };
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const Scaffold(body: Center(child: LoadingView()))),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _ResidentShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
              routes: [GoRoute(path: 'notifications', builder: (context, state) => const NotificationsScreen())],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/account',
              builder: (context, state) => const DebtsScreen(),
              routes: [GoRoute(path: 'payments', builder: (context, state) => const PaymentsScreen())],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/reservations',
              builder: (context, state) => const ReservationsScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  redirect: (context, state) => state.extra is NewReservationArgs ? null : '/reservations',
                  builder: (context, state) => NewReservationScreen(args: state.extra! as NewReservationArgs),
                ),
                GoRoute(
                  path: 'detail',
                  redirect: (context, state) => state.extra is ReservationDetailArgs ? null : '/reservations',
                  builder: (context, state) => ReservationDetailScreen(args: state.extra! as ReservationDetailArgs),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/announcements', builder: (context, state) => const AnnouncementsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/community',
              builder: (context, state) => const CommunityScreen(),
              routes: [
                GoRoute(path: 'new', builder: (context, state) => const NewPostScreen()),
                GoRoute(
                  path: 'post',
                  redirect: (context, state) => state.extra is PostDetailArgs ? null : '/community',
                  builder: (context, state) => PostDetailScreen(args: state.extra! as PostDetailArgs),
                ),
              ],
            ),
          ]),
        ],
      ),
    ],
  );
}

/// Barra inferior de 5 pestañas, visible en todas las pantallas del residente.
class _ResidentShell extends StatelessWidget {
  const _ResidentShell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outline))),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          // Tocar la pestaña activa vuelve a su pantalla inicial.
          onDestinationSelected: (index) => shell.goBranch(index, initialLocation: index == shell.currentIndex),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet),
              label: 'Cuenta',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Reservas',
            ),
            NavigationDestination(icon: Icon(Icons.campaign_outlined), selectedIcon: Icon(Icons.campaign), label: 'Anuncios'),
            NavigationDestination(icon: Icon(Icons.forum_outlined), selectedIcon: Icon(Icons.forum), label: 'Comunidad'),
          ],
        ),
      ),
    );
  }
}

/// Notifica a go_router cada vez que cambia la sesión.
class _StreamListenable extends ChangeNotifier {
  _StreamListenable(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
