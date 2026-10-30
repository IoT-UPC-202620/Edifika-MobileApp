import 'package:edifika_mobile/app/app.dart';
import 'package:edifika_mobile/app/app_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/memory_session_storage.dart';

void main() {
  testWidgets('la app arranca y muestra la URL de la API configurada', (tester) async {
    await tester.pumpWidget(EdifikaApp(dependencies: AppDependencies.create(session: MemorySessionStorage())));

    expect(find.text('Edifika'), findsOneWidget);
    expect(find.textContaining('API: http://10.0.2.2:3000/api/v1'), findsOneWidget);
  });
}
