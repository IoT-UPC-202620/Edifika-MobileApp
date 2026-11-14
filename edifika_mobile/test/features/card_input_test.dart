import 'package:edifika_mobile/core/utils/uuid.dart';
import 'package:edifika_mobile/features/payments/presentation/card_input.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TextEditingValue type(TextInputFormatter f, String text) =>
      f.formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: text));

  test('detecta la marca por el prefijo', () {
    expect(CardBrand.detect('4111'), CardBrand.visa);
    expect(CardBrand.detect('5111'), CardBrand.mastercard);
    expect(CardBrand.detect('2221'), CardBrand.mastercard);
    expect(CardBrand.detect('3712'), CardBrand.amex);
    expect(CardBrand.detect('3600'), CardBrand.diners);
    expect(CardBrand.detect('9999'), CardBrand.unknown);
  });

  test('Luhn: acepta tarjetas de prueba de Culqi y rechaza un digito cambiado', () {
    expect(luhnValid('4111111111111111'), isTrue);
    expect(luhnValid('4000040000000008'), isTrue);
    expect(luhnValid('371212121212122'), isTrue);
    expect(luhnValid('4111111111111112'), isFalse);
  });

  test('formatea el numero 4-4-4-4 (Amex 4-6-5) y corta al largo de la marca', () {
    expect(type(CardNumberFormatter(), '41111111111111119999').text, '4111 1111 1111 1111');
    expect(type(CardNumberFormatter(), '371212121212122').text, '3712 121212 12122');
  });

  test('vencimiento MM/AA: formato, mes valido y no vencido', () {
    expect(type(ExpiryFormatter(), '0930').text, '09/30');
    final now = DateTime(2026, 11, 13);
    expect(parseExpiry('09/30', now: now), (9, 2030));
    expect(parseExpiry('11/26', now: now), (11, 2026));
    expect(parseExpiry('10/26', now: now), isNull);
    expect(parseExpiry('13/30', now: now), isNull);
  });

  test('UUID v4 distinto en cada intento', () {
    final a = uuidV4();
    expect(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$').hasMatch(a), isTrue);
    expect(uuidV4(), isNot(a));
  });
}
