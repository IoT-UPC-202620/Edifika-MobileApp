import 'package:edifika_mobile/app/app.dart';
import 'package:edifika_mobile/app/app_dependencies.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/memory_session_storage.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es'));

  testWidgets('sin sesión guardada la app abre el login', (tester) async {
    await tester.pumpWidget(EdifikaApp(dependencies: AppDependencies.create(session: MemorySessionStorage())));
    await tester.pumpAndSettle();

    expect(find.text('Te damos la bienvenida'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Iniciar sesión'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}
