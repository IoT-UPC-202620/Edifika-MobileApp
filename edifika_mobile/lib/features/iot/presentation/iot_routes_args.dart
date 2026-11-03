import '../domain/iot_models.dart';

/// Datos que la lista ya tiene: el detalle no vuelve a pedirlos.
class IotDeviceDetailArgs {
  const IotDeviceDetailArgs({required this.device, this.gateway, this.telemetry, this.startEnrollment = false});

  final IotDevice device;
  final IotGateway? gateway;
  final DeviceTelemetry? telemetry;

  /// Al abrir, pone el lector en modo registro (se llega desde "Tarjetas RFID").
  final bool startEnrollment;
}

/// Tarjetas de un edificio y los lectores donde se pueden registrar.
class IotCardsArgs {
  const IotCardsArgs({
    required this.buildingId,
    required this.buildingName,
    this.readers = const [],
    this.gateways = const [],
  });

  final int buildingId;
  final String buildingName;

  /// Dispositivos con lector RFID (`RFID` en sus capacidades).
  final List<IotDevice> readers;
  final List<IotGateway> gateways;

  IotGateway? gatewayOf(IotDevice device) {
    for (final g in gateways) {
      if (g.id == device.gatewayId) return g;
    }
    return null;
  }
}

/// Nodos descubiertos en un edificio, con sus gateways para mostrar sus nombres.
class IotDiscoveredArgs {
  const IotDiscoveredArgs({required this.buildingId, required this.buildingName, this.gateways = const []});

  final int buildingId;
  final String buildingName;
  final List<IotGateway> gateways;

  String? gatewayName(int gatewayId) {
    for (final g in gateways) {
      if (g.id == gatewayId) return g.name;
    }
    return null;
  }
}

/// Nodo a adoptar y el nombre del gateway que lo identificó.
class IotAdoptArgs {
  const IotAdoptArgs({required this.discovered, required this.gatewayName});

  final DiscoveredDevice discovered;
  final String gatewayName;
}
