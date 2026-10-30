import 'package:intl/intl.dart';

/// Formatos de presentación (es-PE).
class Formatters {
  const Formatters._();

  static const _symbols = {'PEN': 'S/', 'USD': r'$'};

  /// `850, PEN` → `S/ 850.00`. Se respeta la moneda que envía la API
  /// (Figma muestra `$`, pero la fake API trabaja en soles).
  static String money(double amount, [String currency = 'PEN']) {
    final symbol = _symbols[currency.toUpperCase()] ?? currency.toUpperCase();
    return '$symbol ${NumberFormat('#,##0.00', 'en_US').format(amount)}';
  }

  /// `2026-10-09` → `09/10/2026`
  static String date(String isoDate) {
    final parsed = DateTime.tryParse(isoDate);
    return parsed == null ? isoDate : DateFormat('dd/MM/yyyy').format(parsed);
  }

  /// `2026-10-09T08:00:00` → `09/10/2026 · 08:00`
  static String dateTime(String? isoDateTime) {
    final parsed = isoDateTime == null ? null : DateTime.tryParse(isoDateTime);
    return parsed == null ? '' : DateFormat('dd/MM/yyyy · HH:mm').format(parsed);
  }

  /// `Viernes, 09 de octubre`
  static String longDay(DateTime date) {
    final text = DateFormat("EEEE, dd 'de' MMMM", 'es').format(date);
    return text[0].toUpperCase() + text.substring(1);
  }

  /// `17/10/2026 · Sábado`
  static String dateWithWeekday(DateTime date) {
    final weekday = DateFormat('EEEE', 'es').format(date);
    return '${DateFormat('dd/MM/yyyy').format(date)} · ${weekday[0].toUpperCase()}${weekday.substring(1)}';
  }

  /// `yyyy-MM-dd` (formato de la API).
  static String apiDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  /// `9` → `09:00`
  static String hour(int hour) => '${hour.toString().padLeft(2, '0')}:00';

  /// `16, 18` → `16:00–18:00`
  static String hourRange(int from, int to) => '${hour(from)}–${hour(to)}';
}
