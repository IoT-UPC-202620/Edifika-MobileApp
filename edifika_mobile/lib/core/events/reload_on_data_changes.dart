import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Para cubits de pantallas que viven en una pestaña (conservan su estado):
/// recargan en silencio cuando otra pantalla modifica datos. Agrupa ráfagas
/// (p. ej. una reserva de varias horas) en una sola recarga.
mixin ReloadOnDataChanges<S> on Cubit<S> {
  StreamSubscription<void>? _dataChangesSub;
  Timer? _dataChangesDebounce;

  void listenDataChanges(Stream<void>? changes, void Function() reload) {
    _dataChangesSub = changes?.listen((_) {
      _dataChangesDebounce?.cancel();
      _dataChangesDebounce = Timer(const Duration(milliseconds: 300), () {
        if (!isClosed) reload();
      });
    });
  }

  @override
  Future<void> close() async {
    _dataChangesDebounce?.cancel();
    await _dataChangesSub?.cancel();
    return super.close();
  }
}
