import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Pausa el refresco automático cuando la app pasa a segundo plano y lo
/// reanuda al volver, para no consultar al backend con la pantalla apagada.
class PauseWhenInBackground extends StatefulWidget {
  const PauseWhenInBackground({super.key, required this.onPause, required this.onResume, required this.child});

  final VoidCallback onPause;
  final VoidCallback onResume;
  final Widget child;

  @override
  State<PauseWhenInBackground> createState() => _PauseWhenInBackgroundState();
}

class _PauseWhenInBackgroundState extends State<PauseWhenInBackground> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(onHide: widget.onPause, onShow: widget.onResume);
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// "Actualizado hace 4 s" / "hace 2 min". Se repinta cada segundo para que la
/// antigüedad del dato sea visible sin recargar.
class UpdatedAgo extends StatefulWidget {
  const UpdatedAgo({super.key, required this.at, this.prefix = 'Actualizado'});

  final DateTime? at;
  final String prefix;

  static String format(Duration age) {
    final seconds = age.inSeconds < 0 ? 0 : age.inSeconds;
    if (seconds < 60) return 'hace $seconds s';
    if (seconds < 3600) return 'hace ${seconds ~/ 60} min';
    return 'hace ${seconds ~/ 3600} h';
  }

  @override
  State<UpdatedAgo> createState() => _UpdatedAgoState();
}

class _UpdatedAgoState extends State<UpdatedAgo> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final at = widget.at;
    if (at == null) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.sync, size: 14, color: AppColors.onSurfaceVariant),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '${widget.prefix} ${UpdatedAgo.format(DateTime.now().difference(at))}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
