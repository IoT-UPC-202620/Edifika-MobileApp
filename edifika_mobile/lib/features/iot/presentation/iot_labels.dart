import 'package:flutter/material.dart';

import '../../../core/widgets/status_chip.dart';

/// Textos y tonos de presentación de los estados IoT. El estado siempre se
/// muestra en texto además del color.
class IotLabels {
  const IotLabels._();

  static (String, StatusTone) deviceStatus(String status) => switch (status.toUpperCase()) {
        'ACTIVE' => ('En línea', StatusTone.success),
        'OFFLINE' => ('Sin conexión', StatusTone.danger),
        'MAINTENANCE' => ('En mantenimiento', StatusTone.pending),
        'PROVISIONED' => ('Por activar', StatusTone.neutral),
        'DECOMMISSIONED' => ('Dado de baja', StatusTone.neutral),
        _ => (status, StatusTone.neutral),
      };

  static (String, StatusTone) gatewayStatus(String status) => switch (status.toUpperCase()) {
        'ONLINE' => ('En línea', StatusTone.success),
        'OFFLINE' => ('Sin conexión', StatusTone.danger),
        'PROVISIONED' => ('Por activar', StatusTone.neutral),
        'DECOMMISSIONED' => ('Dado de baja', StatusTone.neutral),
        _ => (status, StatusTone.neutral),
      };

  static (String, StatusTone) credentialStatus(String status) => switch (status.toUpperCase()) {
        'ACTIVE' => ('Activa', StatusTone.success),
        'SUSPENDED' => ('Suspendida', StatusTone.pending),
        'REVOKED' => ('Revocada', StatusTone.danger),
        'LOST' => ('Perdida', StatusTone.danger),
        _ => (status, StatusTone.neutral),
      };

  /// Revocada o perdida: el backend permite volver a entregarla a otro titular.
  static bool isRetiredCredential(String? status) => const {'REVOKED', 'LOST'}.contains(status?.toUpperCase());

  /// Rol principal de un usuario del IAM para mostrarlo junto a su nombre.
  static String? userRole(List<String> roles) {
    final upper = roles.map((r) => r.toUpperCase().replaceFirst('ROLE_', '')).toSet();
    if (upper.contains('OWNER')) return 'Propietario';
    if (upper.contains('TENANT')) return 'Inquilino';
    if (upper.contains('ADMIN')) return 'Administrador';
    return null;
  }

  static String deviceType(String type) => switch (type.toUpperCase()) {
        'DOOR' => 'Puerta',
        _ => type,
      };

  static IconData deviceIcon(String type) => switch (type.toUpperCase()) {
        'DOOR' => Icons.door_front_door_outlined,
        _ => Icons.memory_outlined,
      };

  static String accessMode(String mode) => switch (mode.toUpperCase()) {
        'FREE_ACCESS' => 'Acceso libre',
        'RESERVED' => 'Reservada',
        _ => mode,
      };

  /// Capacidades del nodo de puerta y el componente del ESP32 que las provee
  /// (ver README del repo esp32 → "Mapeo de componentes").
  static ({String label, IconData icon}) capability(String capability) => switch (capability.toUpperCase()) {
        'RFID' => (label: 'Lector RFID (RC522)', icon: Icons.contactless_outlined),
        'LOCK' => (label: 'Cerradura (relé)', icon: Icons.lock_outline),
        'BUZZER' => (label: 'Buzzer', icon: Icons.volume_up_outlined),
        'OLED' => (label: 'Pantalla OLED', icon: Icons.screenshot_monitor_outlined),
        'RGB_LED' => (label: 'LED RGB', icon: Icons.lightbulb_outline),
        'TEMPERATURE' => (label: 'Temperatura (DHT11)', icon: Icons.thermostat_outlined),
        'HUMIDITY' => (label: 'Humedad (DHT11)', icon: Icons.water_drop_outlined),
        _ => (label: capability, icon: Icons.memory_outlined),
      };

  static ({String label, IconData icon}) magnitude(String magnitude) => switch (magnitude.toUpperCase()) {
        'TEMPERATURE' => (label: 'Temperatura', icon: Icons.thermostat_outlined),
        'HUMIDITY' => (label: 'Humedad', icon: Icons.water_drop_outlined),
        'ULTRASONIC' => (label: 'Distancia', icon: Icons.straighten_outlined),
        _ => (label: magnitude, icon: Icons.sensors_outlined),
      };

  /// `24.5, °C` → `24.5 °C`; `null` → `Sin lectura`.
  static String reading(double? value, String unit) {
    if (value == null) return 'Sin lectura';
    final text = value == value.roundToDouble() ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
    return unit.isEmpty ? text : (unit == '%' ? '$text%' : '$text $unit');
  }
}
