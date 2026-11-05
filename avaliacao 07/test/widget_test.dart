import 'package:flutter_test/flutter_test.dart';

import 'package:animated_responsive_layout/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Carrega o widget principal da aplicação
    await tester.pumpWidget(const MainApp());

    // Aguarda a renderização dos frames das animações e assets
    await tester.pumpAndSettle();

    // Confirma que a aplicação abriu sem erros (procura o widget MainApp)
    expect(find.byType(MainApp), findsOneWidget);
  });
}