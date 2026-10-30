import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/edifika_logo.dart';
import '../../../core/widgets/feedback_views.dart';
import '../../../core/widgets/screen_scaffold.dart';
import 'login_cubit.dart';
import 'session_cubit.dart';

/// Mockup 01 · Login.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<LoginCubit>().submit(email: _email.text, password: _password.text);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final notice = context.select((SessionCubit c) => c.state.notice);

    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => current.user != null && previous.user == null,
      listener: (context, state) => context.read<SessionCubit>().signedIn(state.user!),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.screen),
                children: [
                  const Align(alignment: Alignment.centerLeft, child: EdifikaLogo()),
                  const SizedBox(height: AppSpacing.lg),
                  const _HeroBanner(),
                  const SizedBox(height: AppSpacing.xxl),
                  Semantics(header: true, child: Text('Te damos la bienvenida', style: textTheme.headlineMedium)),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Acceso para residentes. Tus pagos, reservas y vecinos, en un solo lugar.',
                    style: textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  if (notice != null && state.error == null) ...[
                    InfoBanner(title: notice),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  LabeledField(
                    label: 'Correo electrónico',
                    child: TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'tu@correo.com',
                        suffixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                  ),
                  LabeledField(
                    label: 'Contraseña',
                    child: TextField(
                      controller: _password,
                      obscureText: _obscure,
                      autofillHints: const [AutofillHints.password],
                      onSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          tooltip: _obscure ? 'Mostrar contraseña' : 'Ocultar contraseña',
                          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),
                  ),
                  if (state.error != null) ...[
                    Semantics(
                      liveRegion: true,
                      child: Text(state.error!, style: textTheme.bodyMedium?.copyWith(color: AppColors.error)),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  CheckboxListTile(
                    value: state.remember,
                    onChanged: (value) => context.read<LoginCubit>().toggleRemember(value ?? false),
                    title: Text('Recordar sesión', style: textTheme.bodyMedium?.copyWith(color: AppColors.onSurface)),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Recuperar contraseña: pendiente de integración. Contacta a tu administración.'),
                        ),
                      ),
                      child: const Text('Recuperar contraseña'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton.icon(
                    onPressed: state.submitting ? null : _submit,
                    icon: state.submitting
                        ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.arrow_forward),
                    label: Text(state.submitting ? 'Ingresando…' : 'Iniciar sesión'),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Acceso seguro para residentes.\n¿Necesitas ayuda? Contacta a tu administración.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Reemplaza la foto del edificio del mockup (no se exportó el asset).
class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF3A1F45), Color(0xFF1C1424)],
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: const Text(
        'Tu hogar, más conectado.',
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}
