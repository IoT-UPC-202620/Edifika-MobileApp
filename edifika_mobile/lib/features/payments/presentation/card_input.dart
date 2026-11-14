import 'package:flutter/services.dart';

/// Marca de la tarjeta segun su prefijo (IIN).
enum CardBrand {
  visa('Visa', 16, 3),
  mastercard('Mastercard', 16, 3),
  amex('American Express', 15, 4),
  diners('Diners Club', 14, 3),
  unknown('', 16, 3);

  const CardBrand(this.label, this.length, this.cvvLength);

  final String label;
  final int length;
  final int cvvLength;

  static CardBrand detect(String digits) {
    if (digits.startsWith('4')) return visa;
    if (RegExp(r'^3[47]').hasMatch(digits)) return amex;
    if (RegExp(r'^(36|38|30[0-5])').hasMatch(digits)) return diners;
    if (RegExp(r'^(5[1-5]|2(2[2-9]|[3-6]\d|7[01]|720))').hasMatch(digits)) return mastercard;
    return unknown;
  }

  /// Grupos de digitos: 4-4-4-4 (Visa/Mastercard), 4-6-5 (Amex), 4-6-4 (Diners).
  List<int> get groups => switch (this) {
        amex => const [4, 6, 5],
        diners => const [4, 6, 4],
        _ => const [4, 4, 4, 4],
      };
}

String onlyDigits(String value) => value.replaceAll(RegExp(r'\D'), '');

/// Validacion de Luhn (Culqi en modo test acepta numeros invalidos; la app los rechaza antes).
bool luhnValid(String digits) {
  if (digits.length < 12) return false;
  var sum = 0;
  var doubleIt = false;
  for (var i = digits.length - 1; i >= 0; i--) {
    var d = digits.codeUnitAt(i) - 48;
    if (doubleIt) {
      d *= 2;
      if (d > 9) d -= 9;
    }
    sum += d;
    doubleIt = !doubleIt;
  }
  return sum % 10 == 0;
}

/// Formatea el numero mientras se escribe: "4111 1111 1111 1111" (o 4-6-5 para Amex).
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final brand = CardBrand.detect(onlyDigits(newValue.text));
    final digits = onlyDigits(newValue.text);
    final limited = digits.length > brand.length ? digits.substring(0, brand.length) : digits;
    final buffer = StringBuffer();
    var index = 0;
    for (final size in brand.groups) {
      if (index >= limited.length) break;
      if (buffer.isNotEmpty) buffer.write(' ');
      final end = (index + size).clamp(0, limited.length);
      buffer.write(limited.substring(index, end));
      index = end;
    }
    final text = buffer.toString();
    return TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

/// Vencimiento "MM/AA".
class ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var digits = onlyDigits(newValue.text);
    if (digits.length > 4) digits = digits.substring(0, 4);
    final text = digits.length > 2 ? '${digits.substring(0, 2)}/${digits.substring(2)}' : digits;
    return TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

/// (mes, anio de 4 digitos) si "MM/AA" es valido y no esta vencido; si no, null.
(int, int)? parseExpiry(String value, {DateTime? now}) {
  final match = RegExp(r'^(\d{2})/(\d{2})$').firstMatch(value);
  if (match == null) return null;
  final month = int.parse(match.group(1)!);
  final year = 2000 + int.parse(match.group(2)!);
  if (month < 1 || month > 12) return null;
  final today = now ?? DateTime.now();
  final lastValidDay = DateTime(year, month + 1, 0);
  if (lastValidDay.isBefore(DateTime(today.year, today.month, today.day))) return null;
  return (month, year);
}
