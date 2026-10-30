import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Isotipo (edificio) + logotipo "Edifika", dibujado como vector.
class EdifikaLogo extends StatelessWidget {
  const EdifikaLogo({super.key, this.size = 30});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Edifika',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(size: Size.square(size), painter: const _BuildingMarkPainter(AppColors.primary)),
          const SizedBox(width: 4),
          Text(
            'Edifika',
            style: TextStyle(
              fontSize: size * 0.82,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              height: 1,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildingMarkPainter extends CustomPainter {
  const _BuildingMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Grilla de 24 unidades, proporciones tomadas del logo de Figma.
    final u = size.width / 24;
    Rect r(double l, double t, double rr, double b) => Rect.fromLTRB(l * u, t * u, rr * u, b * u);

    final path = Path()
      ..fillType = PathFillType.evenOdd
      // Torre izquierda con cuatro ventanas.
      ..addRect(r(1, 2, 11, 23))
      ..addRect(r(3, 4, 9, 5.8))
      ..addRect(r(3, 8, 9, 9.8))
      ..addRect(r(3, 12, 9, 13.8))
      ..addRect(r(3, 16, 9, 17.8))
      // Bloque derecho con hueco interior.
      ..addRect(r(11, 7, 23, 23))
      ..addRect(r(13, 9, 21, 21));
    canvas.drawPath(path, Paint()..color = color);

    // Dos barras dentro del hueco del bloque derecho.
    final bars = Paint()..color = color;
    canvas.drawRect(r(15, 12, 19, 13.8), bars);
    canvas.drawRect(r(15, 16, 19, 17.8), bars);
  }

  @override
  bool shouldRepaint(_BuildingMarkPainter oldDelegate) => oldDelegate.color != color;
}
