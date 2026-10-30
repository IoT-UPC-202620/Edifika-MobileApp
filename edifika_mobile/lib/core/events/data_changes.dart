import 'dart:async';

/// Aviso de "los datos del residente cambiaron" (reserva creada o cancelada,
/// notificación leída, publicación creada…). Los repositorios lo emiten tras
/// cada escritura y las pantallas que mantienen estado (p. ej. Inicio, que
/// vive en una pestaña) se recargan.
class DataChanges {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get stream => _controller.stream;

  void notify() => _controller.add(null);

  Future<void> dispose() => _controller.close();
}
