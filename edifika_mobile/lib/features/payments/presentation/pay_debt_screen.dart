import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/uuid.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import '../../auth/presentation/session_cubit.dart';
import '../data/culqi_tokenizer.dart';
import '../domain/payment_models.dart';
import '../domain/payment_result.dart';
import '../domain/payments_repository.dart';
import 'card_input.dart';

class PayDebtArgs {
  const PayDebtArgs({required this.debt});

  final Debt debt;
}

enum _Phase { form, processing, success, rejected, failed }

/// Pagar una deuda con tarjeta (solo OWNER, desde "Mis deudas").
///
/// 1. La tarjeta se tokeniza directo contra Culqi con la llave publica ([CulqiTokenizer]).
/// 2. Solo el token va al backend: `POST /payments` con una Idempotency-Key (UUID) por intento.
/// Los datos de la tarjeta viven solo en los campos de texto de esta pantalla: no se guardan,
/// no se loguean y se borran al salir.
class PayDebtScreen extends StatefulWidget {
  const PayDebtScreen({super.key, required this.args, this.tokenizer});

  final PayDebtArgs args;

  /// Inyectable en pruebas.
  final CulqiTokenizer? tokenizer;

  @override
  State<PayDebtScreen> createState() => _PayDebtScreenState();
}

class _PayDebtScreenState extends State<PayDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  late final TextEditingController _email;
  late final CulqiTokenizer _tokenizer = widget.tokenizer ?? CulqiTokenizer();

  _Phase _phase = _Phase.form;
  CardBrand _brand = CardBrand.unknown;
  String? _formError;
  String? _resultMessage;
  bool _canRetrySame = false;
  PaymentResult? _result;

  /// Un intento = una clave. Se conserva para reintentar tras un error de red (el backend
  /// devuelve el mismo pago sin volver a cobrar) y se renueva al pagar con otra tarjeta.
  String? _attemptKey;

  /// Token de un solo uso de Culqi (no es dato de tarjeta); se reutiliza solo en el reintento.
  String? _token;

  Debt get _debt => widget.args.debt;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: context.read<SessionCubit>().state.user?.email ?? '');
    _number.addListener(() {
      final brand = CardBrand.detect(onlyDigits(_number.text));
      if (brand != _brand) setState(() => _brand = brand);
    });
  }

  @override
  void dispose() {
    // Limpia los datos de la tarjeta al salir de la pantalla.
    _clearCard();
    _number.dispose();
    _expiry.dispose();
    _cvv.dispose();
    _email.dispose();
    super.dispose();
  }

  void _clearCard() {
    _number.clear();
    _expiry.clear();
    _cvv.clear();
    _token = null;
  }

  Future<void> _pay() async {
    if (_phase == _Phase.processing) return; // evita doble envio
    // En el reintento tras error de red el formulario no esta montado: sus datos ya se validaron.
    if (_phase == _Phase.form && !(_formKey.currentState?.validate() ?? false)) return;
    final expiry = parseExpiry(_expiry.text);
    if (expiry == null && _token == null) return;
    setState(() {
      _phase = _Phase.processing;
      _formError = null;
    });
    _attemptKey ??= uuidV4();

    try {
      _token ??= await _tokenizer.createToken(
        cardNumber: onlyDigits(_number.text),
        cvv: _cvv.text,
        expirationMonth: expiry!.$1,
        expirationYear: expiry.$2,
        email: _email.text.trim(),
      );
      final result = await context
          .read<PaymentsRepository>()
          .payDebt(debtId: _debt.id, culqiToken: _token!, idempotencyKey: _attemptKey!);
      if (!mounted) return;
      if (result.isConfirmed) {
        _clearCard();
        setState(() {
          _result = result;
          _phase = _Phase.success;
        });
      } else if (result.isRejected) {
        setState(() {
          _result = result;
          _resultMessage = result.declineMessage ?? 'La tarjeta fue rechazada.';
          _phase = _Phase.rejected;
        });
      } else {
        // REGISTERED / PENDING_VERIFICATION: no reintentar para no cobrar dos veces.
        setState(() {
          _resultMessage = 'Tu pago quedó en verificación. Te avisaremos cuando se confirme; no lo intentes de nuevo.';
          _canRetrySame = false;
          _phase = _Phase.failed;
        });
      }
    } on CulqiTokenException catch (error) {
      if (!mounted) return;
      setState(() {
        if (error.network) {
          _resultMessage = error.message;
          _canRetrySame = true;
          _phase = _Phase.failed;
        } else {
          // Culqi rechazo los datos (no hubo cobro): se vuelve al formulario con el mensaje.
          _formError = error.message;
          _phase = _Phase.form;
        }
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      final network = error.kind == ApiErrorKind.network || error.kind == ApiErrorKind.timeout;
      setState(() {
        _resultMessage = switch (error.statusCode) {
          _ when network => 'No hay conexión. Revisa tu internet y vuelve a intentarlo: no se cobrará dos veces.',
          502 => 'El procesador de pagos no respondió. Tu pago quedó en verificación; no lo intentes de nuevo.',
          409 => error.message,
          _ => error.message,
        };
        _canRetrySame = network;
        _phase = _Phase.failed;
      });
    }
  }

  void _retryWithAnotherCard() {
    setState(() {
      _clearCard();
      _attemptKey = null; // nuevo intento, nueva Idempotency-Key
      _result = null;
      _resultMessage = null;
      _formError = null;
      _phase = _Phase.form;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _phase != _Phase.processing,
      child: ScreenScaffold(
        title: 'Pagar deuda',
        location: _debt.description,
        body: switch (_phase) {
          _Phase.form || _Phase.processing => _buildForm(context),
          _Phase.success => _buildSuccess(context),
          _Phase.rejected => _buildRejected(context),
          _Phase.failed => _buildFailed(context),
        },
      ),
    );
  }

  Widget _amountCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      tone: AppCardTone.highlighted,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monto a pagar', style: textTheme.labelMedium),
          const SizedBox(height: AppSpacing.sm),
          // El backend cobra el monto de la deuda en soles; aqui solo se muestra.
          Text(Formatters.money(_debt.amount, 'PEN'), style: textTheme.displaySmall),
          const SizedBox(height: AppSpacing.xs),
          Text('${_debt.description} · vence ${Formatters.date(_debt.dueDate)}', style: textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final processing = _phase == _Phase.processing;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _amountCard(context),
          const SizedBox(height: AppSpacing.xl),
          TextFormField(
            controller: _number,
            enabled: !processing,
            keyboardType: TextInputType.number,
            autofillHints: const [AutofillHints.creditCardNumber],
            inputFormatters: [CardNumberFormatter()],
            decoration: InputDecoration(
              labelText: 'Número de tarjeta',
              hintText: '4111 1111 1111 1111',
              prefixIcon: const Icon(Icons.credit_card),
              suffixText: _brand == CardBrand.unknown ? null : _brand.label,
            ),
            validator: (value) {
              final digits = onlyDigits(value ?? '');
              final brand = CardBrand.detect(digits);
              if (brand == CardBrand.unknown) return 'Aceptamos Visa, Mastercard, American Express y Diners.';
              if (digits.length != brand.length || !luhnValid(digits)) return 'Número de tarjeta inválido.';
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiry,
                  enabled: !processing,
                  keyboardType: TextInputType.number,
                  inputFormatters: [ExpiryFormatter()],
                  decoration: const InputDecoration(labelText: 'Vencimiento', hintText: 'MM/AA'),
                  validator: (value) => parseExpiry(value ?? '') == null ? 'Fecha inválida o vencida.' : null,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: TextFormField(
                  controller: _cvv,
                  enabled: !processing,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                  decoration: const InputDecoration(labelText: 'CVV', hintText: '•••'),
                  validator: (value) =>
                      (value ?? '').length != _brand.cvvLength ? 'CVV de ${_brand.cvvLength} dígitos.' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _email,
            enabled: !processing,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Correo para el comprobante', prefixIcon: Icon(Icons.mail_outline)),
            validator: (value) =>
                RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch((value ?? '').trim()) ? null : 'Correo inválido.',
          ),
          if (_formError != null) ...[
            const SizedBox(height: AppSpacing.md),
            InfoBanner(title: 'No se pudo validar la tarjeta', message: _formError, icon: Icons.error_outline),
          ],
          const SizedBox(height: AppSpacing.xl),
          FilledButton.icon(
            // Bloqueado mientras procesa (la Idempotency-Key es la segunda proteccion).
            onPressed: processing ? null : _pay,
            icon: processing
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.lock_outline),
            label: Text(processing ? 'Procesando pago…' : 'Pagar ${Formatters.money(_debt.amount, 'PEN')}'),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Los datos de tu tarjeta se envían cifrados directamente a Culqi; Edifika no los guarda.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final result = _result!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.check_circle, color: AppColors.success, size: 72),
        const SizedBox(height: AppSpacing.lg),
        Text('¡Pago realizado!', style: textTheme.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Formatters.money(result.amount, result.currency), style: textTheme.displaySmall),
              const SizedBox(height: AppSpacing.sm),
              Text(_debt.description, style: textTheme.bodyLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Fecha: ${Formatters.instant(result.paymentDate, fallback: Formatters.instant(DateTime.now().toUtc().toIso8601String()))}',
                style: textTheme.bodyMedium,
              ),
              Text('Operación N.° ${result.id}', style: textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        FilledButton(onPressed: () => context.pop(true), child: const Text('Volver a mis deudas')),
      ],
    );
  }

  Widget _buildRejected(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.cancel, color: AppColors.error, size: 72),
        const SizedBox(height: AppSpacing.lg),
        Text('Pago rechazado', style: textTheme.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.md),
        Text(_resultMessage ?? '', style: textTheme.bodyLarge, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.sm),
        Text('No se realizó ningún cobro.', style: textTheme.bodySmall, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.xl),
        FilledButton.icon(
          onPressed: _retryWithAnotherCard,
          icon: const Icon(Icons.credit_card),
          label: const Text('Reintentar con otra tarjeta'),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton(onPressed: () => context.pop(false), child: const Text('Volver a mis deudas')),
      ],
    );
  }

  Widget _buildFailed(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(_canRetrySame ? Icons.wifi_off : Icons.hourglass_top, color: AppColors.error, size: 72),
        const SizedBox(height: AppSpacing.lg),
        Text(_canRetrySame ? 'Sin conexión' : 'No se pudo completar el pago',
            style: textTheme.headlineSmall, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.md),
        Text(_resultMessage ?? '', style: textTheme.bodyLarge, textAlign: TextAlign.center),
        const SizedBox(height: AppSpacing.xl),
        if (_canRetrySame)
          FilledButton.icon(
            // Mismo intento (misma Idempotency-Key): si el cobro ya se hizo, no se repite.
            onPressed: _pay,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton(onPressed: () => context.pop(false), child: const Text('Volver a mis deudas')),
      ],
    );
  }
}
