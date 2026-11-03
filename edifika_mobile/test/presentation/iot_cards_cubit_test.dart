import 'package:edifika_mobile/core/network/api_exception.dart';
import 'package:edifika_mobile/core/utils/load_status.dart';
import 'package:edifika_mobile/features/iot/domain/iot_models.dart';
import 'package:edifika_mobile/features/iot/presentation/iot_cards_cubit.dart';
import 'package:edifika_mobile/features/profile/domain/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fakes.dart';

void main() {
  late MockIotRepository iot;
  late MockProfileRepository profile;

  const owner = UserProfile(id: 4, fullName: 'Propietario Demo', email: 'propietario@edifika.com', roles: ['OWNER']);
  const ownerCard = AccessCredential(id: 1, rfidUid: '04A1B2C3', buildingId: 12, userId: 4, holderName: 'Propietario Demo', status: 'ACTIVE');
  const lostCard = AccessCredential(id: 2, rfidUid: '0499AA11', buildingId: 12, userId: 4, holderName: 'Ana', status: 'LOST');
  const suspendedCard = AccessCredential(id: 3, rfidUid: '04CCDD22', buildingId: 12, holderName: 'Bruno', status: 'SUSPENDED');

  IotCardsCubit build() => IotCardsCubit(iot, buildingId: 12, profile: profile);

  setUp(() {
    iot = MockIotRepository();
    profile = MockProfileRepository();
    when(() => profile.getUsers()).thenAnswer((_) async => const [owner]);
  });

  test('carga las tarjetas del edificio con los usuarios del IAM', () async {
    when(() => iot.getCredentials(12)).thenAnswer((_) async => const [lostCard, ownerCard, suspendedCard]);

    final cubit = build();
    await cubit.load();

    expect(cubit.state.status, LoadStatus.ready);
    expect(cubit.state.activeCount, 1);
    // Activas primero, luego suspendidas y al final las dadas de baja
    expect(cubit.state.visible.map((c) => c.id), [1, 3, 2]);
    expect(cubit.state.userOf(ownerCard)?.email, 'propietario@edifika.com');
  });

  test('filtra activas e inactivas', () async {
    when(() => iot.getCredentials(12)).thenAnswer((_) async => const [lostCard, ownerCard, suspendedCard]);
    final cubit = build();
    await cubit.load();

    cubit.setFilter(CardFilter.active);
    expect(cubit.state.visible.map((c) => c.id), [1]);

    cubit.setFilter(CardFilter.inactive);
    expect(cubit.state.visible.map((c) => c.id), [3, 2]);
  });

  test('si el IAM falla igual muestra las tarjetas con el titular guardado', () async {
    when(() => iot.getCredentials(12)).thenAnswer((_) async => const [suspendedCard]);
    when(() => profile.getUsers()).thenThrow(const ApiException(ApiErrorKind.network, 'Sin conexión'));

    final cubit = build();
    await cubit.load();

    expect(cubit.state.status, LoadStatus.ready);
    expect(cubit.state.holderOf(suspendedCard), 'Bruno');
  });

  test('un error al cargar las tarjetas se muestra en pantalla', () async {
    when(() => iot.getCredentials(12)).thenThrow(const ApiException(ApiErrorKind.unauthorized, 'No autorizado'));

    final cubit = build();
    await cubit.load();

    expect(cubit.state.status, LoadStatus.failure);
    expect(cubit.state.error, 'No autorizado');
  });

  test('suspender actualiza la tarjeta en la lista', () async {
    when(() => iot.getCredentials(12)).thenAnswer((_) async => const [ownerCard]);
    when(() => iot.changeCredentialStatus(1, 'SUSPENDED')).thenAnswer((_) async => ownerCard.copyWith(status: 'SUSPENDED'));

    final cubit = build();
    await cubit.load();
    await cubit.changeStatus(ownerCard, 'SUSPENDED');

    expect(cubit.state.credentials.single.status, 'SUSPENDED');
    expect(cubit.state.busyCredentialId, isNull);
    expect(cubit.state.message, 'Tarjeta 04A1B2C3: suspendida.');
  });

  test('si el cambio de estado falla avisa y no toca la lista', () async {
    when(() => iot.getCredentials(12)).thenAnswer((_) async => const [ownerCard]);
    when(() => iot.changeCredentialStatus(1, 'REVOKED')).thenThrow(const ApiException(ApiErrorKind.server, 'Error del servidor'));

    final cubit = build();
    await cubit.load();
    await cubit.changeStatus(ownerCard, 'REVOKED');

    expect(cubit.state.credentials.single.status, 'ACTIVE');
    expect(cubit.state.message, 'Error del servidor');
  });
}
