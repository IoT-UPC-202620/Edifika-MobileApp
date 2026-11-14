import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/feedback_views.dart';
import '../features/access/presentation/my_access_screen.dart';
import '../features/admin/presentation/admin_home_screen.dart';
import '../features/announcements/presentation/announcements_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/session_cubit.dart';
import '../features/forum/presentation/community_screen.dart';
import '../features/forum/presentation/new_post_screen.dart';
import '../features/forum/presentation/post_detail_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/iot/presentation/iot_cards_screen.dart';
import '../features/iot/presentation/iot_device_detail_screen.dart';
import '../features/iot/presentation/iot_discovery_screens.dart';
import '../features/iot/presentation/iot_management_screen.dart';
import '../features/iot/presentation/iot_routes_args.dart';
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
        SessionStatus.authenticated => _authenticatedRedirect(
            location,
            isAdmin: session.state.user?.isAdmin ?? false,
            isTenantOnly: session.state.user?.isTenantOnly ?? false,
          ),
      };
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const Scaffold(body: Center(child: LoadingView()))),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      // Navegación del administrador: inicio con resumen y, desde ahí, la gestión IoT.
      GoRoute(path: _adminHome, builder: (context, state) => const AdminHomeScreen()),
      GoRoute(
        path: _adminIot,
        builder: (context, state) => const IotManagementScreen(),
        routes: [
          GoRoute(
            path: 'device',
            redirect: (context, state) => state.extra is IotDeviceDetailArgs ? null : _adminIot,
            builder: (context, state) => IotDeviceDetailScreen(args: state.extra! as IotDeviceDetailArgs),
          ),
          GoRoute(
            path: 'discovered',
            redirect: (context, state) => state.extra is IotDiscoveredArgs ? null : _adminIot,
            builder: (context, state) => IotDiscoveredScreen(args: state.extra! as IotDiscoveredArgs),
          ),
          // Hermana de `discovered`, no hija: cada página recibe sus propios argumentos.
          GoRoute(
            path: 'adopt',
            redirect: (context, state) => state.extra is IotAdoptArgs ? null : _adminIot,
            builder: (context, state) => IotAdoptScreen(args: state.extra! as IotAdoptArgs),
          ),
          GoRoute(
            path: 'cards',
            redirect: (context, state) => state.extra is IotCardsArgs ? null : _adminIot,
            builder: (context, state) => IotCardsScreen(args: state.extra! as IotCardsArgs),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _ResidentShell(
          shell: shell,
          isTenantOnly: session.state.user?.isTenantOnly ?? false,
        ),
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
          // Rama 4: Mis accesos (OWNER y TENANT)
          StatefulShellBranch(routes: [
            GoRoute(path: '/access', builder: (context, state) => const MyAccessScreen()),
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

const _adminHome = '/admin';
const _adminIot = '/admin/iot';

/// Cada rol queda dentro de su propia navegación: el administrador en
/// `/admin/...` y el residente en sus pestañas. El inquilino no tiene "Cuenta".
String? _authenticatedRedirect(String location, {required bool isAdmin, required bool isTenantOnly}) {
  final home = isAdmin ? _adminHome : '/home';
  if (location == '/login' || location == '/splash') return home;
  final inAdminArea = location.startsWith('/admin');
  if (isAdmin != inAdminArea) return home;
  if (isTenantOnly && location.startsWith('/account')) return home;
  return null;
}

/// Pestaña visible -> rama del shell. Ramas: 0 Inicio, 1 Cuenta, 2 Reservas,
/// 3 Anuncios, 4 Mis accesos, 5 Comunidad.
class _Tab {
  const _Tab(this.branch, this.icon, this.selectedIcon, this.label);

  final int branch;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

const _home = _Tab(0, Icons.home_outlined, Icons.home, 'Inicio');
const _account = _Tab(1, Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Cuenta');
const _reservations = _Tab(2, Icons.calendar_month_outlined, Icons.calendar_month, 'Reservas');
const _announcements = _Tab(3, Icons.campaign_outlined, Icons.campaign, 'Anuncios');
const _access = _Tab(4, Icons.key_outlined, Icons.key, 'Accesos');
const _community = _Tab(5, Icons.forum_outlined, Icons.forum, 'Comunidad');

/// OWNER: Inicio, Cuenta, Reservas, Anuncios, Comunidad, Mis accesos.
const _ownerTabs = [_home, _account, _reservations, _announcements, _community, _access];

/// TENANT: Inicio, Reservas, Anuncios, Comunidad, Mis accesos (sin Cuenta).
const _tenantTabs = [_home, _reservations, _announcements, _community, _access];

/// Barra inferior del residente; las pestañas dependen del rol.
class _ResidentShell extends StatelessWidget {
  const _ResidentShell({required this.shell, required this.isTenantOnly});

  final StatefulNavigationShell shell;
  final bool isTenantOnly;

  @override
  Widget build(BuildContext context) {
    final tabs = isTenantOnly ? _tenantTabs : _ownerTabs;
    final selected = tabs.indexWhere((t) => t.branch == shell.currentIndex);
    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outline))),
        child: NavigationBar(
          selectedIndex: selected < 0 ? 0 : selected,
          // Con 6 pestañas solo se rotula la seleccionada para que entren en pantalla.
          labelBehavior: tabs.length > 5
              ? NavigationDestinationLabelBehavior.onlyShowSelected
              : NavigationDestinationLabelBehavior.alwaysShow,
          // Tocar la pestaña activa vuelve a su pantalla inicial.
          onDestinationSelected: (index) {
            final branch = tabs[index].branch;
            shell.goBranch(branch, initialLocation: branch == shell.currentIndex);
          },
          destinations: [
            for (final tab in tabs)
              NavigationDestination(icon: Icon(tab.icon), selectedIcon: Icon(tab.selectedIcon), label: tab.label),
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
