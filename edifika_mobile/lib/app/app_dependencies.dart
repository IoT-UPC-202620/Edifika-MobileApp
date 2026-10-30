import 'dart:async';

import 'package:dio/dio.dart';

import '../core/events/data_changes.dart';
import '../core/network/api_client.dart';
import '../core/storage/session_storage.dart';
import '../features/announcements/data/announcements_repository_impl.dart';
import '../features/announcements/domain/announcements_repository.dart';
import '../features/auth/data/auth_repository_impl.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/forum/data/forum_repository_impl.dart';
import '../features/forum/domain/forum_repository.dart';
import '../features/notifications/data/notifications_repository_impl.dart';
import '../features/notifications/domain/notifications_repository.dart';
import '../features/payments/data/payments_repository_impl.dart';
import '../features/payments/domain/payments_repository.dart';
import '../features/profile/data/profile_repository_impl.dart';
import '../features/profile/domain/profile_repository.dart';
import '../features/reservations/data/reservations_repository_impl.dart';
import '../features/reservations/domain/reservations_repository.dart';
import '../features/residential/data/residential_repository_impl.dart';
import '../features/residential/domain/residential_repository.dart';

/// Composición de dependencias. Para apuntar a los microservicios basta con
/// cambiar `API_BASE_URL`; los repositorios no cambian.
class AppDependencies {
  AppDependencies._({
    required this.session,
    required this.sessionExpired,
    required this.dataChanges,
    required this.auth,
    required this.residential,
    required this.payments,
    required this.reservations,
    required this.forum,
    required this.notifications,
    required this.announcements,
    required this.profile,
  });

  /// `httpAdapter` solo se usa en pruebas (respuestas HTTP simuladas).
  factory AppDependencies.create({SessionStorage? session, HttpClientAdapter? httpAdapter}) {
    final storage = session ?? SecureSessionStorage();
    final expired = StreamController<void>.broadcast();
    final Dio dio = createApiClient(session: storage, onUnauthorized: () => expired.add(null));
    if (httpAdapter != null) dio.httpClientAdapter = httpAdapter;
    final changes = DataChanges();

    return AppDependencies._(
      session: storage,
      sessionExpired: expired,
      dataChanges: changes,
      auth: AuthRepositoryImpl(dio, storage),
      residential: ResidentialRepositoryImpl(dio),
      payments: PaymentsRepositoryImpl(dio),
      reservations: ReservationsRepositoryImpl(dio, changes),
      forum: ForumRepositoryImpl(dio, changes),
      notifications: NotificationsRepositoryImpl(dio, changes),
      announcements: AnnouncementsRepositoryImpl(dio, changes),
      profile: ProfileRepositoryImpl(dio),
    );
  }

  final SessionStorage session;

  /// Emite cuando el servidor responde 401 con un token: la sesión se cerró.
  final StreamController<void> sessionExpired;

  /// Emite tras cada escritura (reserva, cancelación, lectura, publicación).
  final DataChanges dataChanges;

  final AuthRepository auth;
  final ResidentialRepository residential;
  final PaymentsRepository payments;
  final ReservationsRepository reservations;
  final ForumRepository forum;
  final NotificationsRepository notifications;
  final AnnouncementsRepository announcements;
  final ProfileRepository profile;
}
